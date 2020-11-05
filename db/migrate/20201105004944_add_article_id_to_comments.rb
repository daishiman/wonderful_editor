class AddArticleIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :article, :foreign_key => true
    change_column_null :comments, :article_id, false
  end
end
