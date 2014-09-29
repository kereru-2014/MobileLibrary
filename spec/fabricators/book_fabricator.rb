Fabricator(:book) do
  title { Faker::Lorem.sentence}
  author {Faker::Name.name}
  ISBN {Faker::Lorem.word}
    image_url {"http://bks1.books.google.co.nz/books?id=03R7AwAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE716EnvgWt4uXsYwCHm8o7tb18Vw31A5215pKIDDMrVKT3hyS_XR-w6AP8BFsddK8XyhWS52HT0Prr1Xl0H0IjhknKpdmZNkhO599e0gx-L6x9pTUb1yPs7Vmo_KnQgmUa5kRM9B"}
end
