# == Schema Information
#
# Table name: notes
#
#  id            :integer          not null, primary key
#  deleted_at    :datetime
#  generated_pdf :binary
#  kind          :integer          default("invoice"), not null
#  note_number   :string           not null
#  title         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  contact_id    :integer
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
