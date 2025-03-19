# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include ErrorHandler

      before_action :set_user, only: %i[destroy]

      def destroy
        @user.destroy
        head :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
