class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    skip_before_action :authorize, only: :create
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def show
        #user = User.find_by(id: session[:user_id])
        #if user
            render json: @user
        #else
         #   render json: { error: "Not authorized" }, status: :unauthorized
        #end
    end

    def login
        
    end

    private

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def user_params
        params.permit( :username, :password, :password_confirmation, :image_url, :bio)
    end
end