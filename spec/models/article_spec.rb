# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text
#  status     :string           default("draft")
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
  # pending "add some examples to (or delete) #{__FILE__}"

  context "タイトルと本文が入力されているとき" do
    let(:article) { build(:article) }
    it "下書きの状態の記事がかける" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end
  end

  context "status が draft のとき" do
    let(:article) { build(:article, :draft, :user_id => user.id) }
    let(:user) { create(:user) }
    it "記事が draft 状態で作成される" do
      expect(article).to be_valid
      expect(article.status).to eq "draft"
    end
  end

  context "status が published のとき" do
    let(:article) { build(:article, :published, :user_id => user.id) }
    let(:user) { create(:user) }
    it "記事が publisehed 状態で作成される" do
      expect(article).to be_valid
      expect(article.status).to eq "published"
    end
  end

  context "body が記載されていないとき" do
    let(:article) { build(:article, :body => :blank, :user_id => user.id) }
    let(:user) { create(:user) }
    it "article が作成できない" do
      article.valid?
      expect(article.errors.details[:body][0]).to eq nil
    end
  end

  context "title が記載されていないとき" do
    let(:article) { build(:article, :title => nil, :user_id => user.id) }
    let(:user) { create(:user) }
    it "article が作成できない" do
      article.valid?
      expect(article.errors.details[:title][0]).to eq nil
    end
  end

  context "user_id が記載されていないとき" do
    let(:article) { build(:article) }
    let(:user) { create(:user) }
    it "article が作成できない" do
      article.valid?
      expect(article.errors.details[:user_id][0]).to eq nil
    end
  end
end
