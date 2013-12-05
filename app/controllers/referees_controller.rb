class RefereesController < ApplicationController
  before_action :find_referee, :only => [:edit, :update, :destroy]
  before_action :ensure_user_logged_in, :except => [:index, :show]
  
  before_action :ensure_ref_belongs_to_user, :only => [:edit, :update, :delete, :destory]
  before_action :ensure_contest_creator, :except => [:index, :show]

  def ensure_ref_belongs_to_user
    ref_ids=current_user.referees.collect{|ref| ref.id}
    if !params[:id].to_i.in? ref_ids
      flash[:danger] = "This is not your referee."
      redirect_to root_path
    end
  end
  
  def index
  end

  def show
    @referee = Referee.find_by_id(params[:id])
  end

  def new
    @referee = current_user.referees.build
  end
  
  def create
    @referee = current_user.referees.build(accept_params)
    if @referee.save
      flash[:success] = "Referee created successfully."
      redirect_to @referee
    else
      flash[:danger] = "Unsuccessful save."
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @referee.update(accept_params)
      flash[:success] = "Sucessfully updated #{@referee.name.titleize}!"
      redirect_to @referee
    else
      flash[:danger] = "Unsuccessful edit."
      render :edit
    end
  end
  
  def destroy
    @referee = Referee.find_by_id(params[:id])
    if @referee.destroy
      File::delete(@referee.file_location)
      flash[:success] = "Successfully deleted referee."
      redirect_to referees_path
    else
      flash[:danger] = "Could not delete referee."
      redirect_to @referee
    end
  end
  
  private
  def accept_params
    params.require(:referee).permit(:name, :rules_url, :players_per_game, :upload)
  end
  
  def find_referee
    @referee = Referee.find_by_id(params[:id])
  end
  
end
