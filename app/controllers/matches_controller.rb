class MatchesController < ApplicationController
  def index
    @matches= Match.where(manager_id: params[:contest_id])
  end
  def show
    @match = Match.find_by_id params[:id]
  end
end
