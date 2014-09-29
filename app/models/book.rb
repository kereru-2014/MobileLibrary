class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower

  def lend_to(new_borrower)
    self.borrower = new_borrower
    self.lent_date = DateTime.now
    save
  end

  def returned
    borrower = nil
    lent_date = nil
    save
  end
end

