class ContestsController < ApplicationController
  before_filter :find_contest, :only => [:show, :edit, :update, :destroy]
  before_action :ensure_user_logged_in, :except => [:index, :show]
  
  before_action :ensure_contest_creator, :except => [:index, :show]
  
  def index
  end
  
  def show
  end
  
  def new
    @contest = current_user.contests.build
  end
  
  def create
    @contest = current_user.contests.build(accept_params)
    #@contest.referee = Referee.find params[:contest][:referee]
    if @contest.save
      flash[:success] = "Contest created successfully."
      redirect_to @contest
    else
      flash[:danger] = "Unsuccessful save."
      render :new
    end
  end
  
  def edit
  end
  
  def update
    #@contest.referee = Referee.find params[:contest][:referee]
    if @contest.update(accept_params)
      flash[:success] = "Contest updated successfully."
      redirect_to @contest
    else
      flash[:danger] = "Unsuccessful save."
      render :new
    end
  end
  
  def destroy
    if @contest.destroy
      flash[:success] = "Contest successfully deleted."
      redirect_to contests_path
    else
      flash[:danger] = "Unsuccessful delete."
      redirect_to @contest
    end
  end
  
  private
  def accept_params
    params.require(:contest).permit(:name, :description, :contest_type, :deadline, :start, :referee_id)
  end
  def find_contest
    @contest = Contest.find_by_id(params[:id])
  end

end
