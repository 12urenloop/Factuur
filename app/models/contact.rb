# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string(255)      not null
#  vatnumber  :string(255)
#
# Indexes
#
#  index_contacts_on_deleted_at  (deleted_at)
#

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
