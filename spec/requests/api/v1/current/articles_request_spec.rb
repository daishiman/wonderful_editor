require "rails_helper"

RSpec.describe "Api::V1::Current::Articles", :type => :request do
  describe "GET ap i/v1/current/articles" do
    subject { get(api_v1_current_articles_path, :headers => headers) }

    let(:current_user) { create(:user) }
    let(:headers) { current_user.create_new_auth_token }

    context "自分が書いた複数の公開記事が存在する時" do
      let!(:article1) { create(:article, :published, :updated_at => 3.days.ago, :user => current_user) }
      let!(:article2) { create(:article, :published, :updated_at => 2.days.ago, :user => current_user) }
      let!(:article3) { create(:article, :published, :updated_at => 4.days.ago, :user => current_user) }
      before do
        create(:article, :draft, :user => current_user)
        create(:article, :published)
      end

      it "自分の書いた公開記事を更新順に取得できる", :aggregate_failures => false do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq(3)
        article_array = [article2, article1, article3]
        expect(res.map {|i| i["id"] }).to eq(article_array.pluck(:id))
        expect(res[0]["user"]["id"]).to eq current_user.id
        expect(res[0]["user"]["name"]).to eq current_user.name
        expect(response).to have_http_status(:success)
      end
    end
  end
end
