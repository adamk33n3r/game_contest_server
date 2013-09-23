class RemoveConfirmationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :confirmation, :string
    remove_column :users, :password, :string
  end
end
