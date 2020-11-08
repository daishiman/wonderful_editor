# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe "User", :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  context "user の情報が全て揃っているとき" do
    it "user が作成できる" do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  context "name が記載されていないとき" do
    it "user が作成できない" do
      user = build(:user, :name => nil)   # build はカラムの値を決めてレコードを作成したいときに使用する
      expect(user).to be_invalid
      expect(user.errors.details[:name][0][:error]).to eq :blank
    end
  end

  context "email が記載されていいないとき" do
    it "user が作成できない" do
      user = build(:user, :email => nil)
      expect(user).to be_invalid
      expect(user.errors.details[:email][0][:error]).to eq :blank
    end
  end

  context "password が記載されていないとき" do
    it "user が作成できない" do
      user = build(:user, :password => nil)
      expect(user).to be_invalid
      expect(user.errors.details[:password][0][:error]).to eq :blank
    end
  end
end
