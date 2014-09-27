git aclass Book < ActiveRecord::Base
  belongs_to :user
  has_one :borrower
end

