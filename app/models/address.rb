class Address < ActiveRecord::Base
  acts_as_paranoid

  validates :street, :zip_code, :city, :country, presence: true

  belongs_to :contact
end
