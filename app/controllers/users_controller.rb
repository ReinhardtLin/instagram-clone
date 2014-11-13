class UsersController < ApplicationController

  before_action :check_login

  def show
    @user = User.find(params[:id])
  end

end
