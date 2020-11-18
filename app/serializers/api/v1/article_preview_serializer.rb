class Api::V1::ArticlePreviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :updated_at

  has_many :users, :serializer => Api::V1::UserSerializer
  has_many :articles, :serializer => Api::V1::ArticleSerializer
end
