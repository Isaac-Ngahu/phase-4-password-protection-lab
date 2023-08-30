class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid
    def create
        user = User.create!(user_params)
        session[:user_id] ||= user.id
        render json: user
    end
    def show
        if session.include? :user_id
            user = User.find(session[:user_id])
            render json: user
        else
            render json: {error:"not authorized"},status: :unauthorized
        end
    end
    private
    def user_params
        params.permit(:username,:password,:password_confirmation)
    end
    def render_not_valid
        render json: {error:"passwords do not match"},status: :unprocessable_entity
    end
end
