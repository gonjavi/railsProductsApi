module Api
  module V1
    class CategoriesController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        categories = Category.all

        render json: CategorySerializer.new(categories).serialized_json
      end
    end
  end
end
