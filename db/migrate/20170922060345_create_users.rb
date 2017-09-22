class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :password
      t.string :name
      t.string :gender

      t.timestamps null: false
    end
    
    add_index :users, [:account], unique: true
  end
end
