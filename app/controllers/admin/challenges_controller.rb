class Admin::ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  layout "admin"

  def index
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenges = @level.challenges
  end

  def new
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenge = Challenge.new
  end

  def create
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenge = Challenge.new(challenge_params)
    @challenge.level = @level
    if @challenge.save
      redirect_to admin_level_challenges_path(@level)
      flash[:notice] = "Challenge created"
    else
      render :new
    end
  end

  def edit
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenge = Challenge.find(params[:id])
  end

  def update
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenge = Challenge.find(params[:id])
    if @challenge.update(challenge_params)
      redirect_to admin_level_challenges_path(@level)
      flash[:notice] = "Challenge updated"
    else
      render :edit
    end
  end

  def destroy
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenge = Challenge.find(params[:id])
    @challenge.destroy
    redirect_to admin_level_challenges_path(@level)
    flash[:alert] = "Challenge deleted"
  end

  private

  def challenge_params
    params.require(:challenge).permit(:title, :subtitle, :goal, :content, :task)
  end

end
