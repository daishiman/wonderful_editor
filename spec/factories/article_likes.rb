# == Schema Information
#
# Table name: article_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :integer
#
# Indexes
#
#  index_article_likes_on_article_id  (article_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#
FactoryBot.define do
  factory :article_like do
    association :user, :factory => :user
    association :article, :factory => :article
  end
end
