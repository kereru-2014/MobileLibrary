class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :ISBN

      t.datetime :lent_date
      t.datetime :reminder_date

      t.timestamps
    end
  end
end
