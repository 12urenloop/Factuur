class Cost < ActiveRecord::Base
  acts_as_paranoid

  enum vat: {v0: 0, v6: 6, v21: 21}

  validates :description, :price, :amount, :vat, presence: true

  belongs_to :note

  def self.vat_i18n_select_options
    self.vats.map do |k, _|
      [I18n.t("mongoid.enums.#{model_name.i18n_key}.vat.#{k}"), k]
    end
  end
end
