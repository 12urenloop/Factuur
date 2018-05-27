class Contact
  include Mongoid::Document
  # Soft delete
  include Mongoid::Paranoia

  embeds_one :address

  has_many :notes

  field :name, type: String
  field :vatnumber, type: String

  validates_presence_of :name

  def to_s
    name
  end

end

class Address
  include Mongoid::Document
  # Soft delete
  include Mongoid::Paranoia

  field :beneficiary, type: String
  field :street, type: String
  field :zip_code, type: String
  field :city, type: String
  field :country, type: String

  validates_presence_of :street, :zip_code, :city, :country

  embedded_in :contact
end
