class Api::V1::ArticleSerializer < ActiveModel::Serializer
  binding.pry
  attributes :id, :title, :body, :updated_at

  binding.pry
  belongs_to :user, :serializer => Api::V1::UserSerializer
  binding.pry
end
