class Book < ActiveRecord::Base
  belongs_to :own
  belongs_to :borrow

end
