class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower
  scope :overdue, -> { where("reminder_date < ?", DateTime.now) }

  def lend_to(new_borrower, number)
    self.borrower = new_borrower
    self.reminder_date = number.weeks.from_now
    self.lent_date = DateTime.now
    save
  end

  def returned
    self.borrower = nil
    lent_date = nil
    save
  end
end

