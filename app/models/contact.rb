class Contact
  include Mongoid::Document
  # Soft delete
  include Mongoid::Paranoia

  field :name,      type: String
  field :vatnumber, type: String

  validates :name, :vatnumber, presence: true

  has_many :notes

  embeds_one :address

  # Overwrite string representation
  def to_s
    name
  end
end
