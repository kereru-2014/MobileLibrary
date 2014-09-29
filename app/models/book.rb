class Book < ActiveRecord::Base
  belongs_to :user
  has_one :borrower

  def lend_to(new_borrower)
    borrower = new_borrower
    lent_date = Date.now
    save
  end

  def returned
    borrower = nil
    lent_date = nil
    save
  end
end

