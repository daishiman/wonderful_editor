class RemoveArticleIdFromArticleLikes < ActiveRecord::Migration[6.0]
  def change
    remove_column :article_likes, :article_id, :integer
  end
end
