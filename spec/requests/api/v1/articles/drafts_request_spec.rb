require "rails_helper"

RSpec.describe "Api::V1::Articles::Drafts", :type => :request do
  let(:current_user) { create(:user) }
  let(:headers) { current_user.create_new_auth_token }

  describe "GET api/v1/articles/drafts" do
    subject { get(api_v1_articles_drafts_path, :headers => headers) }

    context "自分が書いた下書きが存在する時" do
      let!(:article1) { create(:article, :draft, :user => current_user) }
      let!(:article2) { create(:article, :draft) }

      it "自分が書いた下書き一覧のみが表示される" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 1
        expect(res[0]["id"]).to eq article1.id
        expect(res[0].keys).to eq  ["id", "title", "updated_at", "user"]
        expect(res[0]["user"].keys).to eq ["id", "name", "email"]
        expect(res[0]["user"]["id"]).to eq article1.user.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET api/v1/articles/drafts/:id" do
    subject { get(api_v1_articles_draft_path(article_id), :headers => headers) }

    context "指定した id の下書き記事があり" do
      let(:article_id) { article.id }

      context "対象の記事が自分で書いた下書きの時" do
        let(:article) { create(:article, :draft, :user => current_user) }

        it "記事の詳細を取得できる" do
          subject
          res = JSON.parse(response.body)
          expect(res["id"]).to eq article.id
          expect(res["title"]).to eq article.title
          expect(res["body"]).to eq article.body
          expect(res["status"]).to eq article.status
          expect(res["updated_at"]).to be_present
          expect(res["user"]["id"]).to eq article.user.id
          expect(res["user"].keys).to eq ["id", "name", "email"]
          expect(response).to have_http_status(:success)
        end
      end

      context "対象の記事が自分で書いていない下書きの時" do
        let(:article) { create(:article, :draft) }
        it "記事を取得できない" do
          expect { subject }.to raise_error ActiveRecord::RecordNotFound
        end
      end
    end
  end
end
