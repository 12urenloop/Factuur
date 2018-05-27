require 'open3'
require 'tmpdir'

class Note
  include Mongoid::Document
  # created_at, updated_at
  include Mongoid::Timestamps
  # Soft delete
  include Mongoid::Paranoia
  # Factuurtypes
  include Mongoid::Enum

  enum :kind, [:invoice, :credit, :income]

  # Notes should be immutable and never changed.
  validate :force_immutable

  before_create :generate_and_set_pdf

  field :_id, type: String, default: -> { Note.next_id }
  field :generated_pdf, type: BSON::Binary

  embeds_many :costs
  accepts_nested_attributes_for :costs

  belongs_to :contact

  validates_presence_of :contact

  validates_length_of :costs, minimum: 1

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

    results = unscoped.where(:created_at.gte => boy).and(:created_at.lte => eoy).order_by(created_at: :desc)

    if results.empty?
      "#{dt.year}-001"
    else
      results.first.id.next
    end
  end

  # Because mongoid-enums doesn't to I18N
  def self.kind_i18n_select_options
    Note::KIND.map do |k, _|
      [I18n.t("mongoid.enums.#{model_name.i18n_key}.kind.#{k}"), k]
    end
  end

  private

  def generate_and_set_pdf
    self.generated_pdf = BSON::Binary.new(generate_pdf)
  end

  def force_immutable
    return if !changed? || !persisted?

    errors.add(:base, :immutable)
    reload
  end
end

class Cost
  include Mongoid::Document
  include Mongoid::Enum

  enum :vat, [:v0, :v6, :v21]

  field :description, type: String
  field :price, type: BigDecimal, default: 0
  field :amount, type: Integer, default: 1

  validates_presence_of :description, :price, :amount, :vat

  def self.vat_i18n_select_options
    Cost::VAT.map do |k, _|
      [I18n.t("mongoid.enums.#{model_name.i18n_key}.vat.#{k}"), k]
    end
  end
end
