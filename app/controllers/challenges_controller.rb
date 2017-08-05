class ChallengesController < ApplicationController

  def show
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenge = Challenge.find(params[:id])
  end


  private

  def challenge_params
    params.require(:challenge).permit(:title, :subtitle, :goal, :content, :task)
  end

end
