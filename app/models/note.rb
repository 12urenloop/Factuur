require 'open3'
require 'tmpdir'

class Note < ActiveRecord::Base
  acts_as_paranoid

  enum kind: {invoice: 0, credit: 1, income: 2, reminder: 3}

  # Notes should be immutable and never changed.
  validate :force_immutable

  before_create :generate_and_set__id
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

  def self.next_id
    dt = Date.today
    boy = dt.beginning_of_year
    eoy = dt.end_of_year

    results = unscoped.where("created_at >= ?", boy).where("created_at <= ?", eoy).order(id: :desc)

    if results.empty?
      "#{dt.year}-001"
    else
      results.first._id.next
    end
  end

  # Because mongoid-enums doesn't to I18N
  def self.kind_i18n_select_options
    self.kinds.map do |k, _|
      [I18n.t("mongoid.enums.#{model_name.i18n_key}.kind.#{k}"), k]
    end
  end

  private

  def generate_and_set__id
    self._id = self.class.next_id
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
