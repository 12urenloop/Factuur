# == Schema Information
#
# Table name: costs
#
#  id          :integer          not null, primary key
#  amount      :integer          default(1), not null
#  deleted_at  :datetime
#  description :string           not null
#  price       :decimal(8, 2)    default(0.0), not null
#  vat         :integer          default("v21"), not null
#  note_id     :integer
#
# Indexes
#
#  index_costs_on_deleted_at  (deleted_at)
#  index_costs_on_note_id     (note_id)
#

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
