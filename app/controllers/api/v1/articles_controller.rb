module Api::V1
  class ArticlesController < BaseApiController
    # before_action :set_article, only: [:show, :update, :destroy]
    # before_action :authenticate_user!, only: [:create, :update, :destroy]

    def index
      articles = Article.order(:updated_at => :desc)
      render :json => articles, :each_serializer => Api::V1::ArticlePreviewSerializer
    end

    def show
      article = Article.find(params[:id])
      render :json => article
    end

    def create
      article = current_user.articles.create!(article_params)
      render :json => article
    end

    def update
      article = current_user.articles.find(params[:id])
      article.update!(article_params)
      render :json => article
    end

    def destroy
      article = current_user.articles.find(params[:id])
      article.destroy!
    end

    private

      def article_params
        params.require(:article).permit(:title, :body)
      end

    # def set_article
    #   article = current_user.articles.find(params[:id])
    # end
  end
end