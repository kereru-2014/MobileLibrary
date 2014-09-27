class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :borrows
  has_many :owns
  has_many :books, through: :owns
  has_many :borrowed_books, through: :borrows
end
