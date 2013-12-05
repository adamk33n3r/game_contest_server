class PlayersController < ApplicationController
  before_action :get_player, :only => [:show, :edit, :update, :destroy]
  before_action :ensure_user_logged_in, :except => [:index, :show]
  before_action :ensure_correct_user_for_player, only: [:edit, :update, :destroy]
  def index
    @contest = Contest.find_by_id(params[:contest_id])
  end
  def new
    contest = Contest.find_by_id(params[:contest_id])
    @player = contest.players.build
  end
  
  def create
    contest = Contest.find_by_id(params[:contest_id])
    @player = contest.players.build(accept_params)
    @player.user = current_user
    if @player.save
      flash[:success] = "Player created successfully."
      redirect_to @player
    else
      flash[:danger] = "Unsuccessful save."
      render :new
    end
  end
  
  def edit
    @player = Player.find_by_id(params[:id])
  end
  
  def update
    if @player.update(accept_params)
      flash[:success] = "Sucessfully updated #{@player.name.titleize}!"
      redirect_to @player
    else
      flash[:danger] = "Unsuccessful edit."
      render :edit
    end
  end
  
  def destroy
    if @player.destroy
      File::delete(@player.file_location)
      flash[:success] = "Successfully deleted player."
      redirect_to contest_players_path(@player.contest)
    else
      flash[:danger] = "Could not delete player."
      redirect_to @player
    end
  end
  
  private
  def accept_params
    params.require(:player).permit(:name, :description, :upload)
  end
  def get_player
    @player = Player.find(params[:id])
  end

end
