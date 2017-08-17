class UsersController < ApplicationController

  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Update success!"
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  protected

  def user_params
    params.require(:user).permit(:username, :gender, :avatar, :image)
  end

end
