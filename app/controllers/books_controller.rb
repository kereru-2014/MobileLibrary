class BooksController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token

  before_filter :load_book, only: [:show, :lend, :update, :destroy]

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
      "image_url": "http://www.example.com/image.png"
      "borrower_id":null
    }
  ]'
  def index
    render json: Book.all
  end


#--------------------------------------#
#          The #create action          #
#--------------------------------------#

  api :POST, 'api/v1/books', "Add a book object using JSON"
  formats ['json']
  description "Use the create api to add a new book to the database, the JSON will be expected to look like the example.
  The JSON will be sent back to confirm persitance or show errors during persistance"
  example '{
    "title": "Adore Me",
    "author": "The Rat",
    "ISBN":  "0800RATTY",
    "lent_date": null,
    "reminder_date": null,
    "image_url": "http://www.example.com/image.png"
    "borrower_id":null
  }'
  def create
    @book = Book.new(book_params)
    if @book.save
      render json: @book
    else
      redirect_to index_url
    end
  end

#--------------------------------------#
#          The #show action            #
#--------------------------------------#

  api :GET, '/v1/books/:id', "Retrieve a book by Id "
  param :id, String, :desc => "Id of book", :required => true
  description "Find a book by book_id, the book will be returned in a json format as shown in the example"
  example '{
    "id": 2,
    "title": "Cherish Me",
    "author": "The Sock Thief",
    "ISBN":  "0800LOSTASOCK",
    "lent_date": null,
    "reminder_date": null,
    "image_url": "http://www.example.com/image.png"
    "borrower_id":null
  }'
  def show
    render json: @book
  end

#--------------------------------------#
#          The #edit action            #
#--------------------------------------#

  api :EDIT, 'api/v1/books/:id/edit', "Find book by Id and receive JSON to edit"
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
    "borrower_id":null
  }'

  def edit
    render json: Book.find(params[:id])
  end

#--------------------------------------#
#          The #update action     #
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

 # GF doesnt seem to work
  def update
    if @book.update_attributes(book_params)
      #@book.save
      puts "this is the book #{@book.title}"
      puts "this is the parameters #{params[:book]}"
      # redirect_to :action => 'show', :id => @book.id
      # redirect_to @book
      head :ok
    else
      render :action => 'edit'
      #error message
    end
  end

#--------------------------------------#
#         The #delete action           #
#--------------------------------------#

  api :DELETE, 'api/v1/books/:id', "Delete a book of given Id"
  param :id, String, :desc => "Id of book", :required => true
  description "Select a book by its Id to remove it from the library"

  def destroy
    @book.destroy
    redirect_to :action => 'index'
  end

#--------------------------------------#
#          The #lend action            #
#--------------------------------------#

  api :POST, 'api/v1/books/:id/lend', "Update a book's borrower_id by using JSON"
  param :borrower_id, Integer, :desc => "Id of borrower", :required => true
  description "Find book by a book's id, add a borrower, lend by setting book's borrower_id will be returned in a json format as shown in the example"
    example '{
    "borrower_id":2
 }'

  def lend
    @borrower = Borrower.find(params[:borrower_id])
    @book.lend_to(@borrower)
    head :ok
    # redirect_to :action => 'index'
  end

private
  def book_params
    params.require(:book).permit(:title, :author, :ISBN, :lent_date, :reminder_date, :image_url)
  end

  def load_book
    @book = Book.find(params[:id])
  end
end
