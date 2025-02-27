class RecipesController < ApplicationController
    # rescue_from User::NotAuthorized, with: :deny_access
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def index
        #if session.include? :user_id
            render json: Recipe.all
        #else
            #render json: { errors: ["User not authorized."] }, status: :unauthorized
        #end
    end

    def create
        #if session.include? :user_id
        #byebug
            recipe = @user.recipes.create!(recipe_params)
            render json: recipe, include: :user, status: :created
        #else
         #   render json: { errors: ["User not authorized."] }, status: :unauthorized
        #end
    end

    private

    def deny_access(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unauthorized
    end

    def render_unprocessable_entity_response(invalid)
        puts invalid.record.errors.full_messages
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
