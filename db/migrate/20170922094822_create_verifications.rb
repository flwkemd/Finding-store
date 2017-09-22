class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :is_verified
      t.boolean :is_active
      t.string :code

      t.timestamps null: false
    end
  end
end
