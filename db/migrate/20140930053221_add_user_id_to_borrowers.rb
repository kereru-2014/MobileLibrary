class AddUserIdToBorrowers < ActiveRecord::Migration
  def change
    add_reference :borrowers, :user, index: true
  end
end
