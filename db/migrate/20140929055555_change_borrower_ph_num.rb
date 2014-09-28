class ChangeBorrowerPhNum < ActiveRecord::Migration
  def change
    change_column :borrowers, :phone_number, :string
  end
end
