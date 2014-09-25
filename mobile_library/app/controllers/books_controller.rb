class BooksController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render json: Book.all
  end

  def create
    render json: Book.create!(book_params)
  end

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
