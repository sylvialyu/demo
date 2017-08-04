class ChallengesController < ApplicationController

  def show
    @level = Level.find_by_friendly_id!(params[:level_id])
    @challenges = @level.challenges
  end


  private

  def challenge_params
    params.require(:challenge).permit(:title, :subtitle, :goal, :content, :task)
  end

end
