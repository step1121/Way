class Public::VisionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_vision, only: [:show, :edit, :update, :destroy]
  
  def new
    @vision = Vision.new
  end
  
  def create
    @vision = Vision.new(vision_params)
    @vision.user_id = current_user.id
    if @vision.save
      redirect_to vision_path(@vision)
    else
      render :new
    end
  end
  
  def index
    @visions = Vision.page(params[:page])
    @all_visions = Vision.all
  end
  
  def show
    @tasks = @vision.tasks
    @task = Task.new
  end
  
  def edit
  end

  def update
    @vision.update(vision_params) ? (redirect_to vision_path(@vision)) : (render :edit)
  end
  
  def destroy
    @vision.delete
    redirect_to user_path
  end


  private
  
  def vision_params
    params.require(:vision).permit(:title, :genre_id, :body, :finish_on)
  end
  
  def ensure_vision
    @vision = Vision.find(params[:id])
  end
end
