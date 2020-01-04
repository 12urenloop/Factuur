# frozen_string_literal: true

10.times do
  Contact.create(name: Faker::Company.name,
                 vatnumber: Array.new(10) { Random.rand(10) }.join,
                 address_attributes: {
                   beneficiary: Faker::Name.name,
                   street: Faker::Address.street_address,
                   zip_code: Faker::Address.zip_code,
                   city: Faker::Address.city,
                   country: Faker::Address.country
                 })
end

puts 'Created contacts'
