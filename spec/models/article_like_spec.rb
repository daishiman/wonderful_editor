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
require "rails_helper"

# RSpec.describe ArticleLike, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
