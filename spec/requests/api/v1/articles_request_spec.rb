require "rails_helper"

RSpec.describe "Api::V1::Articles", :type => :request do
  describe "GET /articles" do
    subject { get(api_v1_articles_path) }
    # binding.pry
    # 作成時間が異なる article を3つ作る

    let!(:article1) { create(:article, :updated_at => 1.days.ago) }
    let!(:article2) { create(:article, :updated_at => 13.days.ago) }
    let!(:article3) { create(:article, :updated_at => 5.days.ago) }

    it "article_preview が習得できる" do
      subject

      # 作成した article のデータが全て返ってきているか（ article の作成時間をずらしたものを3つ作ってそれが3つとも返ってくるか）
      res = JSON.parse(response.body)
      expect(res.length).to eq(3)

      # article_updated_at の順番になっているか
      article_array = [article1, article3, article2]
      expect(res.map {|i| i["id"] }).to eq(article_array.pluck(:id))

      # 返ってきたのデータはarticle_id, ,article_title, aritcle_updated_at, user_id, user_name, user_email の6つを持っていか
      article_serializer = Api::V1::ArticlePreviewSerializer.new(article1)
      expect(article_serializer.to_h[:id]).to eq(res[0]["id"])
      expect(article_serializer.to_h[:title]).to eq(res[0]["title"])
      expect(article_serializer.to_h[:updated_at].in_time_zone.to_s).to eq(res[0]["updated_at"].in_time_zone.to_s)
      expect(article_serializer.to_h[:user][:id]).to eq(res[0]["user"]["id"])
      expect(article_serializer.to_h[:user][:name]).to eq(res[0]["user"]["name"])
      expect(article_serializer.to_h[:user][:email]).to eq(res[0]["user"]["email"])

      # ステータスコードが 200 であること
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /articles/:id" do
    subject { get(api_v1_article_path(article_id)) }

    let!(:user) { create(:user) }
    let!(:article) { create(:article, :user_id => user.id) }
    let!(:article_id) { article.id }

    context "指定した article_id のユーザーが存在するとき" do
      it "そのユーザーのレコードが取得できる" do
        subject
        res = JSON.parse(response.body)

        expect(res["id"]).to eq article.id
        expect(res["title"]).to eq article.title
        expect(res["body"]).to eq article.body
        expect(res["updated_at"]).to be_present

        # article_serializer = Api::V1::ArticlePreviewSerializer.new(article)
        # expect(res["updated_at"].in_time_zone.to_s).to eq(article_serializer.to_h[:updated_at].in_time_zone.to_s)

        expect(res["user"]["id"]).to eq article.user.id
        expect(res["user"].keys).to eq ["id", "name", "email"]

        expect(response).to have_http_status(:ok)
      end
    end

    context "指定した article_id のユーザーが存在しないとき" do
      let(:article_id) { 10_000_000_000 }
      it "ユーザーが見つからない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
