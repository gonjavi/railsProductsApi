module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session
    
      def index
        user = User.all
        render json: UserSerializer.new(user).serialized_json
      end

      def show
        begin
          user = User.find(params[:id])
          render json: UserSerializer.new(user).serialized_json            
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.to_s }, status: :not_found      
        end               
      end

      def update 
        user = User.find(params[:id])              
        begin
          render json: UserSerializer.new(user).serialized_json if user.update(user_params)
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.to_s }, status: :not_found 
        end
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: UserSerializer.new(user).serialized_json
        else
          render json: { error: user.errors.messages }, status: 422
        end
      end

      def destroy        
        begin      
          user = User.find(params[:id])
          user.destroy  
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.to_s }, status: :not_found 
        end
      end
     
      def user_params
        params.require(:user).permit(:name, :last_name)
      end
    end
  end
end
