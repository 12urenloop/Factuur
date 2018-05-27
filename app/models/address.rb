class Address
  include Mongoid::Document
  # Soft delete
  include Mongoid::Paranoia

  field :beneficiary, type: String
  field :street,      type: String
  field :zip_code,    type: String
  field :city,        type: String
  field :country,     type: String

  validates :street, :zip_code, :city, :country, presence: true

  embedded_in :contact
end
