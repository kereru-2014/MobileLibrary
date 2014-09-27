class ChangeBorrowersAndBooks < ActiveRecord::Migration
  def change
    add_column :books, :borrower_id, :integer
    remove_column :borrowers, :book_id
  end
end
