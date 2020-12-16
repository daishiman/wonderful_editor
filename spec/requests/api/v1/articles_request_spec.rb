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

  describe "POST /articles" do
    subject { post(api_v1_articles_path, :params => params, :headers => headers) }

    context "適切なパラメータを送信したとき" do
      let!(:current_user) { create(:user) }
      let!(:params) { { :article => attributes_for(:article) } }
      let!(:headers) { current_user.create_new_auth_token }

      it " article レコードが作成できる" do
        # expect { subject }.to change { Article.count }.by(1)
        expect { subject }.to change { Article.where(:user_id => current_user.id).count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["body"]).to eq params[:article][:body]
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH(PUT)/articles/:id" do
    subject { patch(api_v1_article_path(article.id), :params => params, :headers => headers) }

    let!(:current_user) { create(:user) }
    let!(:params) { { :article => attributes_for(:article) } }
    let!(:headers) { current_user.create_new_auth_token }

    context "自分の記事のレコードを更新するとき" do
      let(:article) { create(:article, :user => current_user) }
      it "記事を更新できる" do
        expect { subject }.to change { article.reload.title }.from(article.title).to(params[:article][:title]) &
                              change { article.reload.body }.from(article.body).to(params[:article][:body]) &
                              not_change { article.created_at }
        expect(response).to have_http_status(:ok)
      end
    end

    context "自分の記事と違うレコードを更新するとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, :user => other_user) }

      it "記事を更新できない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound) &
                              change { Article.count }.by(0)
      end
    end
  end

  describe "DELETE /articles/:id" do
    subject { delete(api_v1_article_path(article.id), :headers => headers) }

    let!(:current_user) { create(:user) }
    let(:article_id) { article.id }
    let!(:headers) { current_user.create_new_auth_token }

    context "自分の記事のレコードを削除するとき" do
      let!(:article) { create(:article, :user => current_user) }
      it "記事を削除できる" do
        expect { subject }.to change { Article.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context "自分の記事と違うレコードを削除するとき" do
      let(:other_user) { create(:user) }
      let!(:article) { create(:article, :user => other_user) }

      it "記事を削除できない" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound) &
                              change { Article.count }.by(0)
      end
    end
  end
end
