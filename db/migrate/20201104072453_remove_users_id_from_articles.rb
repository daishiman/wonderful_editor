class RemoveUsersIdFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :users_id, :integer
  end
end
