# frozen_string_literal: true

Given(/^an note with id "([^"]*)"$/) do |id|
  @note = Note.create(id: id, contact: @contact)
end

Given(/^a contact named "([^"]*)"$/) do |name|
  data = {
    name: name,
    vatnumber: 'BE1382041234',
    address_attributes: {
      beneficiary: 'Foo',
      street: 'Bar',
      zip_code: 'Bar',
      city: 'Bar',
      country: 'Bar'
    }
  }
  @contact = Contact.create(data)
end

When(/^we try to edit the note$/) do
  @note.contact = nil
end

Then(/^saving should not succeed$/) do
  expect(@note.save).to be false
end

Then(/^a pdf should have been generated alongside it$/) do
  expect(@note.generated_pdf).to_not be nil
  expect(MimeMagic.by_magic(@note.generated_pdf).type).to eq('application/pdf')
end

Given(/^the user is on the page to create a new note$/) do
  visit '/notes/new'
end

When(/^the user fills in the note information$/) do
  fill_in 'Netto', with: 30
end

When(/^the user clicks on the submit button$/) do
  click_on 'Submit'
end

Then(/^an note is created$/) do
  expect(Note.count).to eq(2)
end

Then(/^the user should see the new note$/) do
  expect(page).to have_current_path(note_path(id: Note.last.id))
end

Given(/^the year is (\d+)$/) do |year|
  Timecop.freeze(Time.new(year))
end

When(/^we create a new note$/) do
  Note.create
end

Then(/^the note id should be (.+)$/) do |id|
  Note.last.note_number == id
end
