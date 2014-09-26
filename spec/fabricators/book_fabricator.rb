Fabricator(:book) do
  title { Faker::Lorem.sentence}
  author {Faker::Name.name}
  ISBN {Faker::Lorem.word}
  image_url {Faker::Internet.url}
end
