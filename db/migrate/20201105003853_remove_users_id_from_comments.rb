class RemoveUsersIdFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :users_id, :integer
  end
end
