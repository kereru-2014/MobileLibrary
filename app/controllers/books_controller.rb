class BooksController < ApplicationController
  protect_from_forgery with: :null_session

# v1/books_controller.rb

#--------------------------------------#
#          The #get index action       #
#--------------------------------------#

  api :GET, '/v1/books', "Get all books fromt the library"
  formats ['JSON']
  description "Get all books from library for a users ID. Note user user must be logged in"
  example '[
    {
      "title": "Owls do cry",
      "author": "Janet Frame",
      "ISBN":  "0807609560",
      "lent_date": null,
      "reminder_date": null
    },
    {
      "title": "Love Me",
      "author": "The Pigeon",
      "ISBN":  "0800PIGEON",
      "lent_date": null,
      "reminder_date": null
    }
  ]'
  def index
    render json: Book.all
  end


#--------------------------------------#
#          The #create action          #
#--------------------------------------#

  api :POST, '/v1/books', "Add a book object using JSON"
  formats ['json']
  description "Use the create api to add a new book to the database, the JSON will be expected to look like the example.
  The JSON will be sent back to confirm persitance or show errors during persistance"
  example '{
    "book": {
      "title": "Adore Me",
      "author": "The Rat",
      "ISBN":  "0800RATTY",
      "lent_date": null,
      "reminder_date": null
    }
  }'
  def create
    @book = Book.create!(book_params)
    if @book.save
      redirect_to root_url
    else
      render json: @book
    end
  end

#--------------------------------------#
#          The #show action            #
#--------------------------------------#

  api :GET, '/v1/books/:id', "Retrieve a book by Id "
  param :id, String, :desc => "Id of book", :required => true
  description "Find a book by book_id, the book will be returned in a json format as shown in the example"
  example '{
    "book": {
      "title": "Cherish Me",
      "author": "The Sock Thief",
      "ISBN":  "0800LOSTASOCK",
      "lent_date": null,
      "reminder_date": null
    }
  }'
  def show
    render json: Book.find(params[:id])
  end

#--------------------------------------#
#          The #edit action            #
#--------------------------------------#

  api :EDIT, '/v1/books/:id/edit', "Find book by Id and recieve a JSON to edit"
  param :id, String, :desc => "Id of book", :required => true
  description "Find a book by book_id, the book will be returned in a json format as shown in the example for editting"
  example '{
    "book": {
      "title": "Cherish Me",
      "author": "The Sock Thief",
      "ISBN":  "0800LOSTASOCK",
      "lent_date": null,
      "reminder_date": null
    }
  }'
  def edit
    render json: Book.find(params[:id])
  end

#--------------------------------------#
#          The #update action          #
#--------------------------------------#

  api :PATCH, '/v1/books/:id', "Update a book by Id and with a JSON"
  param :id, String, :desc => "Id of book", :required => true
  description "Find book by a books id, the book will be returned in a json format as shown in the example"
    example '{
  "book":
    {
      "title": "Owls do cry",
      "author": "Janet Frame",
      "ISBN":  "0807609560",
      "lent_date": null,
      "reminder_date": null
    }
 }'
  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      #@book.save
      puts "this is the book #{@book.title}"
      puts "this is the parameters #{params[:book]}"
      redirect_to :action => 'show', :id => @book
    else
      render :action => 'edit'
      #error message
    end
  end

#--------------------------------------#
#         The #delete action           #
#--------------------------------------#

  api :DELETE, '/v1/books/:id', "Delete a book of given Id"
  param :id, String, :desc => "Id of book", :required => true
  description "Select a book by its Id to remove it from the library"

  def destroy
    Book.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

private
  def book_params
    params.require(:book).permit(:title, :author, :ISBN, :lent_date, :reminder_date)
  end
end
