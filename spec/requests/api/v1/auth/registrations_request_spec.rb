require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", :type => :request do
  describe "POST /api_v1_auth_registration" do
    subject { post(api_v1_user_registration_path, :params => params) }

    context "登録情報が揃っているとき" do
      let(:params) { attributes_for(:user) }

      it "新規登録できる" do
        expect { subject }.to change { User.count }.by(1)

        res_body = JSON.parse(response.body)
        expect(res_body["data"]["name"]).to eq params[:name]
        expect(res_body["data"]["email"]).to eq params[:email]

        res_header = response.header
        expect(res_header).to include "access-token"
        expect(res_header).to include "client"
        expect(res_header).to include "expiry"
        expect(res_header).to include "uid"
        expect(res_header).to include "token-type"

        expect(response).to have_http_status(:ok)
      end
    end

    context "name が存在しないとき" do
      let(:params) { attributes_for(:user, :name => nil) }

      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["name"]).to include "can't be blank"
      end
    end

    context "email が存在しないとき" do
      let(:params) { attributes_for(:user, :email => nil) }

      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["email"]).to include "can't be blank"
      end
    end

    context "password が存在しないとき" do
      let(:params) { attributes_for(:user, :password => nil) }

      it "エラーする" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["password"]).to include "can't be blank"
      end
    end
  end
end
