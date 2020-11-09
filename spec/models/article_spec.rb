# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe Article, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  context "すべて記載しているとき" do
    let(:article) { create(:article) }
    it "article が作成できる" do
      expect(article).to be_valid
    end
  end

  # context "body が記載されていないとき" do
  #   binding.pry
  #   let(:article) { build(:article, :body => nil) }
  #   it "article が作成できない" do
  #     expect(article).to be_invalid
  #     binding.pry
  #   end
  # end

  # context "title が記載されていないとき" do
  #   it "article が作成できない" do

  #   end
  # end

  # context "user_id が記載されていないとき" do
  #   it "article が作成できない" do

  #   end
  # end
end
