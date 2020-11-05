class AddUserIdToArticleLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :article_likes, :user, foreign_key: true
    change_column_null :article_likes, :user_id, false
  end
end
