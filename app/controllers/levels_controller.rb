class LevelsController < ApplicationController

  def index
    @levels = Level.all
  end

  def show
    @level = Level.find_by_friendly_id!(params[:id])
  end

end
