class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    
    def index
        if session.include? :user_id
            render json: Recipe.all, include: :user, status: 201
        else
            render json: { errors: "invalid.record.errors.full_messages" }, status: :unauthorized
        end
    end

    def create
        if session.include? :user_id
            recipe = Recipe.create!(recipe_params)
            render json: recipe, include: :user, status: :created
        else
            render json: { errors: "invalid.record.errors.full_messages" }, status: :unauthorized
        end
    end

    private

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def recipe_params
        params.permit(:user_id, :title, :instructions, :minutes_to_complete)
    end
end
