class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  has_many :articles, :serializer => Api::V1::ArticleSerializer
  belongs_to :article_previewa, :serializer => Api::V1::ArticlePreviewSerializer
end
