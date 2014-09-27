Fabricator(:borrower) do
  name { Faker::Name.name}
  email {Faker::Internet.email }
  phone_number {Faker::PhoneNumber.phone_number}
  book_id {5}

end
