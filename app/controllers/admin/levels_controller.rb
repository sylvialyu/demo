class Admin::LevelsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @levels = Level.all
  end

  def new
    @level = Level.new
  end

  def create
    @level = Level.new(level_params)
    if @level.save
      redirect_to admin_levels_path
      flash[:notice] = "Level created!"
    else
      render :new
    end
  end

  def edit
    @level = Level.find(params[:id])
  end

  def update
    @level = Level.find(params[:id])
    if @level.update(level_params)
      redirect_to admin_levels_path
      flash[:notice] = "Level updated!"
    else
      render :edit
    end
  end

  def destroy
    @level = Level.find(params[:id])
    @level.destroy
    redirect_to admin_levels_path
    flash[:alert] = "Level deleted!"
  end

  private

  def level_params
    params.require(:level).permit(:title, :image)
  end

end
