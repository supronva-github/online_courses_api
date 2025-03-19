class Api::V1::UsersController < ApplicationController
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
