class UsersController < ApplicationController
  before_filter :authenticate_user!

api :GET, 'api/v1/users/:id/overdue', "Return a list of overdue books"
param :id, String, :desc => "Overdue books", :required => true
description "See a list of overdue books in a json format as shown in the example"
example '[
  {
      "id": 12,
      "title": "A Pattern Language",
      "author": "Sara Ishikawa,Murray Silverstein",
      "ISBN": null,
      "lent_date": "2014-09-30T23:48:07.856Z",
      "reminder_date": "2014-09-29T23:48:07.855Z",
      "created_at": "2014-09-30T22:07:03.260Z",
      "updated_at": "2014-10-01T00:01:32.713Z",
      "image_url": "http://bks8.books.google.co.nz/books?id=hwAHmktpk5IC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
      "borrower_id": 3,
      "user_id": 1
  },
  {
      "id": 16,
      "title": "Here Comes the Poo Bus",
      "author": "Andy Stanton",
      "ISBN": null,
      "lent_date": null,
      "reminder_date": null,
      "created_at": "2014-10-01T00:05:01.537Z",
      "updated_at": "2014-10-01T00:05:01.537Z",
      "image_url": "http://bks0.books.google.co.nz/books?id=rUZPYAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api",
      "borrower_id": 5,
      "user_id": 1
  }
]'

  def overdue
    overdue_books = current_user.books.overdue
    render json: overdue_books
  end
end
