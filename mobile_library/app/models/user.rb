class User < ActiveRecord::Base
  has_many :borrows
  has_many :owns
  has_many :books, through: :owns
  has_many :borrowed_books, through: :borrows
end
