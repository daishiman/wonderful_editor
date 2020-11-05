class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :user, :foreign_key => true
    change_column_null :articles, :user_id, false
  end
end
