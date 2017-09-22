class AddIsVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_verified, :boolean, :null => false, :default => false
  end
end
