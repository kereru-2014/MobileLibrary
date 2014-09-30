class UsersController < ApplicationController
  before_filter :authenticate_user!

  def overdue
    overdue_books = current_user.books.overdue
    render json: overdue_books
  end
end
