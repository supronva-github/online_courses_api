# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[destroy]

      def destroy
        CourseReassignmentService.new(@user).call ? head(:no_content) : head(:unprocessable_entity)
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
