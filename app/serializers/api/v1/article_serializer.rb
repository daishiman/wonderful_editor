class Api::V1::ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  belongs_to :user, :serializer => Api::V1::UserSerializer
  belongs_to :article_previewa, :serializer => Api::V1::ArticlePreviewSerializer
end
