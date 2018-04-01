class ExperiencesController < ApplicationController
  before_action :logged_in_user
  before_action :find_experience, only: [:edit, :update, :show, :destroy]

  def show
  end

  def edit
  end

  def update
    @experience.update(experience_params)
    flash[:success] = "工作经历更新成功"
    redirect_to experience_path(@experience)
  end

  def index
    @experiences = current_user.experiences.order("weight desc")
  end

  def new
    @experience = current_user.experiences.build
  end

  def create
    @experience = current_user.experiences.build(experience_params)
    @experience.save
    flash[:success] = "工作经历创建成功"
    redirect_to experiences_path
  end

  def destroy
    @experience.destroy
    flash[:success] = "工作经历删除成功"
    redirect_to experiences_path
  end

  private
    def find_experience
      @experience = current_user.experiences.find(params[:id])
    end

    def experience_params
      params.require(:experience).permit(:company, :position, :description, :datetime,  :weight)
    end
end