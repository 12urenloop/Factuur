# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  beneficiary :string(255)
#  city        :string(255)      not null
#  country     :string(255)      not null
#  deleted_at  :datetime
#  street      :string(255)      not null
#  zip_code    :string(255)      not null
#  contact_id  :bigint           not null
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
