# == Schema Information
#
# Table name: article_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer
#  user_id    :integer
#
FactoryBot.define do
  factory :article_like do
    user_id { 1 }
    article_id { 1 }
  end
end
