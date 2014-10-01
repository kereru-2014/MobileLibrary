class BooksController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token

  before_filter :load_book, only: [:show, :lend, :update, :destroy, :return, :edit]

# v1/books_controller.rb

#--------------------------------------#
#          The #get index action       #
#--------------------------------------#

  api :GET, 'api/v1/books', "Get all books from the library"
  formats ['JSON']
  description "Get all books from library for a users ID. Note user must be logged in"
  example '[
    {
      "id:" 1,
      "title": "Owls do cry",
      "author": "Janet Frame",
      "ISBN":  "0807609560",
      "lent_date": null,
      "reminder_date": null,
      "created_at":"2014-09-27T06:15:30.943Z",
      "updated_at":"2014-09-27T06:15:30.943Z",
      "image_url": "http://www.example.com/image.png"
      "borrower_id":null
      "user_id": 1
    },
    {
      "id:" 2,
      "title": "Love Me",
      "author": "The Pigeon",
      "ISBN":  "0800PIGEON",
      "lent_date": null,
      "reminder_date": null,
      "created_at":"2014-09-27T06:15:30.943Z",
      "updated_at":"2014-09-27T06:15:30.943Z",
      "image_url": "http://www.example.com/image.png",
      "borrower_id":null,
      "user_id": 1
    }
  ]'

  def index
    render json: current_user.books
  end

#--------------------------------------#
#          The #create action          #
#--------------------------------------#

  api :POST, 'api/v1/books', "Add a book object using JSON"
  formats ['json']
  description "Use the create api to add a new book to the database, the JSON will be expected to look like the example.
  The JSON will be sent back to confirm persitance or show errors during persistance"
  example '[{
    "title":"Adore Me",
    "author":"The Rat",
    "ISBN":"0800RATTY",
    "lent_date":null,
    "reminder_date":null,
    "image_url": "http://www.example.com/image.png"
    "borrower_id":null
  }]'

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      render json: @book
    else
      redirect_to index_url
    end
  end

#--------------------------------------#
#          The #show action            #
#--------------------------------------#

  api :GET, '/v1/books/:id', "Retrieve a book by id "
  param :id, String, :desc => "Id of book", :required => true
  description "Find a book by book_id, the book will be returned in a json format as shown in the example"
  example '{
    "id": 2,
    "title": "Cherish Me",
    "author": "The Sock Thief",
    "ISBN":  "0800LOSTASOCK",
    "lent_date": null,
    "reminder_date": null,
    "created_at":"2014-09-30T20:37:42.606Z",
    "updated_at":"2014-09-30T20:37:42.606Z"
    "image_url": "http://www.example.com/image.png"
    "borrower_id":null,
    "user_id":1
  }'

  def show
    render json: @book
  end

#--------------------------------------#
#          The #edit/show action       #
#--------------------------------------#

  api :GET, 'api/v1/books/:id/edit', "Find book by id and receive JSON to edit"
  param :id, String, :desc => "Id of book", :required => true
  description "Find a book by book_id, the book will be returned in a json format as shown in the example for editing"
  example '{
    "id": 2,
    "title": "Cherish Me",
    "author": "The Sock Thief",
    "ISBN":  "0800LOSTASOCK",
    "lent_date": null,
    "reminder_date": null,
    "created_at":"2014-09-27T06:15:30.952Z",
    "updated_at": "2014-09-28T03:49:56.773Z",
    "image_url": "http://www.example.com/image.png"
    "borrower_id":null,
    "user_id":1
  }'

  def edit
    render json: @book
  end

#--------------------------------------#
#          The #update action          #
#--------------------------------------#

  api :PATCH, 'api/v1/books/:id', "Update a book by searching by Id using JSON"
  param :id, String, :desc => "Id of book", :required => true
  description "Find book by a book's id, the book will be returned in a json format as shown in the example"
  example '{
    "title": "Owls do cry",
    "author": "Janet Frame",
    "ISBN":  "0807609560",
    "lent_date": null,
    "reminder_date": null,
    "image_url": "http://www.example.com/image.png"
    "borrower_id":null
 }'

  def update
    @book.update_attributes(book_params)
    render json: @book
  end

#--------------------------------------#
#         The #delete action           #
#--------------------------------------#

  api :DELETE, 'api/v1/books/:id', "Delete a book of given id"
  param :id, String, :desc => "Id of book", :required => true
  description "Select a book by its Id to remove it from the library"

  def destroy
    @book.destroy
    head :accepted
  end

#--------------------------------------#
#     The #find on google action       #
#--------------------------------------#

  api :POST, '/api/v1/books/find', "Search for a book using the Google Books Api"
  param :q, String, :desc => "Search input", :required => true
  description "Find a book by searching Google Books"
  example '{
    "q":"The wind in the willows"
  }'

  def find
    search_item = GoogleBooks::Search.find(params["q"])
    render json: search_item
  end

#--------------------------------------#
#          The #lend action            #
#--------------------------------------#

  api :PATCH, 'api/v1/books/:id/lend', "Update a book's borrower_id and reminder_date by using JSON"
  param :borrower_id, String, :desc => "Id of borrower, and week amount by string", :required => true
  description "Find book by a book's id, add a borrower, set a reminder_date, lend by setting book's borrower_id will be returned in a json format as shown in the example"
  example '{
    "id": 14,
    "title": "In Cold Blood",
    "author": "Truman Capote",
    "ISBN": null,
    "lent_date": "2014-09-30T23:41:40.367Z",
    "reminder_date": "2014-10-07T23:41:40.367Z",
    "created_at": "2014-09-30T22:07:07.621Z",
    "updated_at": "2014-09-30T23:41:40.416Z",
    "image_url": "http://www.example.com/image.png",
    "borrower_id": 4,
    "user_id": 1
  }'

  def lend
    @borrower = Borrower.find(params[:borrower_id])
    @book.lend_to(@borrower, params[:reminder_date])
    render json: @book
  end

#--------------------------------------#
#         The #return action           #
#--------------------------------------#

  api :PATCH, 'api/v1/books/:id/return', "Update a book's borrower_id by using JSON"
  description "change the borrower_id (against a book) to nil."

  def return
    @book.returned
    head :ok
  end

private
  def book_params
    params.require(:book).permit(:title, :author, :ISBN, :lent_date, :reminder_date, :image_url)
  end

  def load_book
    @book = current_user.books.find(params[:id])
  end
end
