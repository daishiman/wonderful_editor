# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Comment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  context "すべて記載しているとき" do
    let(:comment) { create(:comment, :user_id => user.id, :article_id => article.id) }
    let(:user) { create(:user) }
    let(:article) { create(:article, :user_id => user.id) }
    it "comment が作成できる" do
      expect(comment).to be_valid
    end
  end

  context "user_id が記載されていないとき" do
    let(:comment) { build(:comment, :user_id => nil, :article_id => article.id) }
    let(:user) { create(:user) }
    let(:article) { create(:article, :user_id => user.id) }
    it " comment が作成できない" do
      comment.valid?
      expect(comment.errors.details[:user_id][0][:error]).to eq :blank
    end
  end

  context "article_id が記載されていないとき " do
    let(:comment) { build(:comment, :user_id => user.id, :article_id => nil) }
    let(:user) { create(:user) }
    let(:article) { create(:article, :user_id => user.id) }
    it " comment が作成できない" do
      comment.valid?
      expect(comment.errors.details[:article_id][0][:error]).to eq :blank
    end
  end
end
