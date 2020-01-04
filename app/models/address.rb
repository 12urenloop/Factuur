# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  beneficiary :string
#  city        :string           not null
#  country     :string           not null
#  deleted_at  :datetime
#  street      :string           not null
#  zip_code    :string           not null
#  contact_id  :integer          not null
#
# Indexes
#
#  index_addresses_on_contact_id  (contact_id)
#  index_addresses_on_deleted_at  (deleted_at)
#

class Address < ActiveRecord::Base
  acts_as_paranoid

  validates :street, :zip_code, :city, :country, presence: true

  belongs_to :contact
end
