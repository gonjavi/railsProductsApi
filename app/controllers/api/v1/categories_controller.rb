module Api
  module V1
    class CategoriesController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :set_category, only: %i[update]

      def index
        categories = Category.all

        render json: CategorySerializer.new(categories).serialized_json
      end

      def create
        category = Category.new(category_params)
        if category.save
          render json: CategorySerializer.new(category).serialized_json
        else
          render json: { error: category.errors.messages }, status: 422
        end       
      end

      def update
        begin          
          render json: CategorySerializer.new(@category).serialized_json if @category.update(category_params)
        rescue ActionController::ParameterMissing => e
          render json: { error: e.to_s },status: 400
        end
      end

      def destroy
        begin      
          category = Category.find(params[:id])
          category.destroy  
          render json: { ok: true, message: 'Category deleted from database' }
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.to_s }, status: :not_found 
        end
      end

      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :product_id)
      end
    end
  end
end
