module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :set_user, only: %i[destroy update show]

      def index
        user = User.all

        render json: UserSerializer.new(user).serialized_json
      end

      def show
        begin
          render json: UserSerializer.new(@user).serialized_json if @user
        rescue ActiveRecord::RecordNotFound => e
          # puts e.to_s.strip          
        end 
      end

      def update
        if @user.update(user_params)
          render json: UserSerializer.new(@user).serialized_json
        else
          render json: { error: @user.errors.messages }, status: 401
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
        if @user.destroy
          render json: { head: :no_content } 
        else
          render status: 400
        end
      end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :last_name)
      end
    end
  end
end
