class Contact < ActiveRecord::Base
  acts_as_paranoid

  validates :name, presence: true

  has_one :address
  has_many :notes

  accepts_nested_attributes_for :address

  # Overwrite string representation
  def to_s
    name
  end
end
