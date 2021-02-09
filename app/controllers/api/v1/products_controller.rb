module Api
  module V1
    class ProductsController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :set_product, only: %i[destroy update show]

      def index
        products = Product.all

        render json: ProductSerializer.new(products).serialized_json
      end

      def show
        begin
          render json: ProductSerializer.new(@product).serialized_json if @product
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.to_s }, status: :not_found           
        end 
      end

      def update
        begin          
          render json: ProductSerializer.new(@product).serialized_json if @product.update(product_params)
        rescue ActionController::ParameterMissing => e
          render json: { error: e.to_s },status: 400
        end
      end

      def create
        product = Product.new(product_params)
        u = params.require(:product).permit(:user_id)
        user = User.where(id: :u["user_id"])
        if user
          if product.save
            render json: ProductSerializer.new(product).serialized_json
          else
            render json: { error: product.errors.messages }, status: 422
          end
        end
      end

      def destroy
        if @product.destroy
          render json: { head: :no_content } 
        else
          render status: 400
        end
      end

      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.require(:product).permit(:product_name, :seller, :user_id)
      end
    end
  end
end
