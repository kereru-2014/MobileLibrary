class BooksController < ApplicationController
  protect_from_forgery with: :null_session

# v1/books_controller.rb
  def_param_group :book do
    param :book, Hash, :required => false, :action_aware => true do
      param :title, String, "Book title"
      param :author, String, "Authors name"
      param :ISBN, String, "ISBN number"
      param :owner_id, Integer, "User Id of book owner"
      param :borrower_id, Integer, "User Id of book borrower"
      param :lent_date, String, "Date lent out - as string at mo"
      param :reminder_date, String, "Date book is due - Note is string at mo"
      param :image, String, "Image name - as string at mo"
    end
  end

  api :GET, '/v1'
  param_group :book
  def index
    render json: Book.all
  end

  def create
    render json: Book.create!(book_params)
  end

  api :GET, '/v1/books/:id'
  param :id, Integer, "Id of book"
  param_group :book
  def show
    render json: Book.find(params[:id])
  end

  def update
    render text: "congrats you updated a book"
  end

  def destroy
    render text: "destroy, crush, smash!!!"
  end

private
  def book_params
    params.require(:book).permit(:title, :author, :ISBN, :lent_date, :reminder_date)
  end

end
