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

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
