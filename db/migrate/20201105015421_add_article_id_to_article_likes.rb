class AddArticleIdToArticleLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :article_likes, :article, :foreign_key => true
    change_column_null :article_likes, :article_id, false
  end
end
