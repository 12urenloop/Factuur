# == Schema Information
#
# Table name: notes
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  generated_pdf :binary(429496729
#  kind          :integer          default("invoice"), not null
#  note_number   :string(255)      not null
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  contact_id    :bigint
#
# Indexes
#
#  index_notes_on_contact_id  (contact_id)
#  index_notes_on_deleted_at  (deleted_at)
#

require 'open3'
require 'tmpdir'

class Note < ActiveRecord::Base
  acts_as_paranoid

  enum kind: {invoice: 0, credit: 1, income: 2, reminder: 3}

  # Notes should be immutable and never changed.
  #validate :force_immutable

  before_create :generate_and_set_note_number
  before_create :generate_and_set_pdf

  validates :contact, presence: true
  validates :costs,   length: { minimum: 1 }
  validates :title,   presence: true

  has_many :costs
  accepts_nested_attributes_for :costs

  belongs_to :contact

  def generate_pdf
    res = nil
    Dir.mktmpdir do |dir|
      # TODO: Put this in a config
      # command = 'electron-pdf'
      exe = 'node_modules/.bin/electron-pdf'
      exe.prepend('xvfb-run -n 9 ') if Rails.env.production?
      input_file = "#{dir}/input.html"
      output_file = "#{dir}/output.pdf"

      s = ApplicationController.render(
        'notes/note_pdf',
        layout: 'paper',
        locals: {
          note: self
        }
      )
      File.write(input_file, s)

      logger.info '======'
      command = "#{exe} #{input_file} #{output_file}"
      logger.info "Running '#{command}'"
      Open3.popen3(command) do |_, out, err, wait_thr|
        logger.info "STDOUT: #{out.read}"
        logger.info "STDERR: #{err.read}"

        if wait_thr.value == 0
          res = File.binread(output_file)
        else
          errors.add :generated_pdf, 'Error creating PDF. Check logs.'
        end
      end
      logger.info '======'
    end

    res
  end

  def self.next_note_number
    dt = Date.today
    boy = dt.beginning_of_year
    eoy = dt.end_of_year

    results = unscoped.where("created_at >= ?", boy).where("created_at <= ?", eoy).order(id: :desc)

    if results.empty?
      "#{dt.year}-001"
    else
      results.first.note_number.next
    end
  end

  # Because mongoid-enums doesn't to I18N
  def self.kind_i18n_select_options
    self.kinds.map do |k, _|
      [I18n.t("mongoid.enums.#{model_name.i18n_key}.kind.#{k}"), k]
    end
  end

  def self.find_by_note_number_or_id(id)
    unscoped.find_by_note_number(id) || unscoped.find(id)
  end

  private

  def generate_and_set_note_number
    self.note_number = self.class.next_note_number
  end

  def generate_and_set_pdf
    self.generated_pdf = generate_pdf
  end

  def force_immutable
    return unless changed? && persisted?

    errors.add(:base, :immutable)
    reload
  end
end
