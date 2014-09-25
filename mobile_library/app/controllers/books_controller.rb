class BooksController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    render text: "heres all them books"
  end

  def create
    render text: "you added a book"
  end

  def show
    render text: "heres a singular book"
  end

  def update
    render text: "congrats you updated a book"
  end

  def destroy
    render text: "destroy, crush, smash!!!"
  end

end
