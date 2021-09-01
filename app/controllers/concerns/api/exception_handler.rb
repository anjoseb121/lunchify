# frozen_string_literal: true

module Api
  module ExceptionHandler
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        render json: { errors: e.message }, status: :internal_server_error
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        message = "Couldn't find #{e.model} with 'id'=#{e.id}"
        render json: { message: message }, status: :not_found
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        render json: { message: e.message }, status: :unprocessable_entity
      end

      rescue_from ActionController::ParameterMissing do |e|
        render json: { message: e.message }, status: :unprocessable_entity
      end

      rescue_from Pundit::NotAuthorizedError do |e|
        render json: { message: e.message }, status: :unprocessable_entity
      end
    end
  end
end
