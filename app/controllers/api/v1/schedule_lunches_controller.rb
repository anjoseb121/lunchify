module Api
  module V1
    class ScheduleLunchesController < ApiController
      before_action :authenticate_user!
      before_action :set_schedule_lunch, only: %i[show update destroy]

      def index
        schedules = current_user.schedule_lunches.group_by(&:week_of_year)
        render json: schedules
      end

      def show
        render json: @schedule
      end

      def create
        schedule = ScheduleLunch.new(permit_params)
        current_user.schedule_lunches << schedule
        render json: schedule,
                status: :created
      end

      def update
        @schedule.update!(permit_params)
        render json: @lunch
      end

      def destroy
        @schedule.destroy
        render json: {}
      end

      private

      def permit_params
        params.require(:schedule_lunch)
              .permit(:lunch_id, :week_of_year, :day)
      end

      def set_schedule_lunch
        @schedule = current_user.schedule_lunches.find(params[:id])
      end
    end
  end
end
