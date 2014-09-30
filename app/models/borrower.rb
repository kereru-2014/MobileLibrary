class Borrower < ActiveRecord::Base
  has_many :books
  belongs_to :user

  def current_borrower
    borrower.order(:lent_date).first
  end
end
