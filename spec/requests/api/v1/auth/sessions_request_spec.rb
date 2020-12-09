require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", :type => :request do
  describe "POST /api_v1_auth_sign_in" do
    # before { create(:user) }
    subject { post(api_v1_user_session_path, :params => params) }

    context "email, password が正しいとき " do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, :email => user.email, :password => user.password) }

      it "header 情報を取得できる" do
        subject
        header = response.header
        expect(header["access-token"]).to be_present
        expect(header["client"]).to be_present
        expect(header["uid"]).to be_present

        expect(response).to have_http_status(:ok)
      end
    end

    context "email が正しくないとき" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, :email => user.email) }
      it "エラーする" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]).to eq ["Invalid login credentials. Please try again."]

        header = response.header
        expect(header["access-token"]).not_to be_present
        expect(header["client"]).not_to be_present
        expect(header["uid"]).not_to be_present
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "password の記載がないとき" do
      let(:user) { create(:user) }
      let(:params) { attributes_for(:user, :password => user.password) }

      it "エラーする" do
        subject
        res = JSON.parse(response.body)
        expect(res["errors"]).to eq ["Invalid login credentials. Please try again."]

        header = response.header
        expect(header["access-token"]).not_to be_present
        expect(header["client"]).not_to be_present
        expect(header["uid"]).not_to be_present

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
