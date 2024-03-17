# == Schema Information
#
# Table name: notes
#
#  id            :bigint           not null, primary key
#  deleted_at    :datetime
#  generated_pdf :binary(429496729
#  kind          :integer          default("invoice"), not null
#  note_number   :string(255)      not null
#  title         :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  contact_id    :bigint
#
# Indexes
#
#  index_notes_on_contact_id  (contact_id)
#  index_notes_on_deleted_at  (deleted_at)
#

require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
