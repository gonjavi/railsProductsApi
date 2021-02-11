module Api
  module V1
    class ProductsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        products = Product.all

        render json: ProductSerializer.new(products).serialized_json
      end

      def show
        begin
          product = Product.find(params[:id])
          render json: ProductSerializer.new(product).serialized_json if product
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.to_s }, status: :not_found           
        end 
      end

      def update
        begin  
          product = Product.find(params[:id])  
          render json: ProductSerializer.new(product).serialized_json if product.update(product_params)
        rescue => e
          render json: { error: e.to_s }, status: 400
        end
      end

      def create
        product = Product.new(product_params) 
        if product.save
          render json: ProductSerializer.new(product).serialized_json
        else
          render json: { error: product.errors.messages }, status: 422
        end       
      end

      def destroy
        begin      
          product = Product.find(params[:id])
          product.destroy  
          render json: { ok: true, message: 'Product deleted from database' }
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.to_s }, status: :not_found 
        end
      end

      def product_params
        params.require(:product).permit(:product_name, :seller, :user_id)
      end
    end
  end
end
