class CreateApiV1ArticlePreviews < ActiveRecord::Migration[6.0]
  def change
    create_table :api_v1_article_previews do |t|
      t.string :title
      t.timestamps :updated_at

      t.timestamps
    end
  end
end
