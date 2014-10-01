class Borrower < ActiveRecord::Base
  has_many :books
  belongs_to :user

  scope :alphabetically, -> {order("lower(name) ASC")}
end
