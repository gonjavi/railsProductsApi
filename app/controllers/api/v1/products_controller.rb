module Api
  module V1
    class ProductsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        products = Product.all

        render json: ProductSerializer.new(products).serialized_json
      end
    end
  end
end
