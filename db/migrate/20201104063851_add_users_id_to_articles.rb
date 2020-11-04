class AddUsersIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :users_id, :integer
  end
end
