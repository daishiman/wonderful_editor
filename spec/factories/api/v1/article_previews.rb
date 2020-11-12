FactoryBot.define do
  factory :api_v1_article_preview, :class => "Api::V1::ArticlePreview" do
    title { "MyString" }
    body { "MyString" }
  end
end
