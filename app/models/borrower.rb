class Borrower < ActiveRecord::Base
  has_many :books

  def current_borrower
    borrower.order(:lent_date).first
  end

end
