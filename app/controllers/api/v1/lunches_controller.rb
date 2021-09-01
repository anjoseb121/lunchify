module Api
  module V1
    class LunchesController < ApiController
      before_action :authenticate_user!
      before_action :verify_user_auth
      before_action :set_lunch, only: %i[show update destroy]

      def index
        lunches = Lunch.all
        render json: lunches
      end

      def show
        render json: @lunch
      end

      def create
        lunch = Lunch.new(permit_params)
        lunch.save!
        render json: lunch,
                status: :created
      end

      def update
        @lunch.update!(permit_params)
        render json: @lunch
      end

      def destroy
        @lunch.destroy
        render json: {}
      end

      private

      def permit_params
        params.require(:lunch)
              .permit(:name)
      end

      def set_lunch
        @lunch = Lunch.find(params[:id])
      end

      def verify_user_auth
        authorize Lunch
      end
    end
  end
end
