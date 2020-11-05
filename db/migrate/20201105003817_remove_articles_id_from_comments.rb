class RemoveArticlesIdFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :articles_id, :integer
  end
end
