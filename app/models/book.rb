class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower
  scope :overdue, -> { where("reminder_date < ?", DateTime.now) }
  scope :alphabetically, -> {order("lower(title) ASC")}

  def lend_to(new_borrower, number)
    week_num = number.to_i
    self.borrower = new_borrower
    self.reminder_date = week_num.weeks.from_now
    self.lent_date = DateTime.now
    save
  end

  def returned
    self.borrower = nil
    self.reminder_date = nil
    self.lent_date = nil
    save
  end
end
