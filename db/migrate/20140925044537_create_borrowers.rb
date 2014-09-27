class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :name
      t.string :email
      t.integer :phone_number
      t.integer :book_id

      t.timestamps
    end
  end
end
