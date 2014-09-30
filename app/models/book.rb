class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower

  def lend_to(new_borrower)
    self.borrower = new_borrower
    self.lent_date = DateTime.now
    save
  end

  def lend_period
  end

  def returned
    self.borrower = nil
    lent_date = nil
    save
  end
end

