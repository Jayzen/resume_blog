class SkillsController < ApplicationController
  before_action :logged_in_user
  before_action :find_skill, only: [:edit, :update, :show, :destroy]

  def show
  end

  def edit
  end

  def update
    if @skill.update(skill_params)
      flash[:success] = "技术介绍更新成功"
      redirect_to skill_path(@skill)
    else
      render 'edit'
    end
  end

  def index
    @skills = current_user.skills.order("weight desc")
  end

  def new
    @skill = current_user.skills.build
  end

  def create
    @skill = current_user.skills.build(skill_params)
    if @skill.save
      flash[:success] = "技术介绍创建成功"
      redirect_to skills_path
    else
      render 'new'
    end
  end

  def destroy
    @skill.destroy
    flash[:success] = "技术介绍删除成功"
    redirect_to skills_path
  end

  private
    def find_skill
      @skill = current_user.skills.find(params[:id])
    end

    def skill_params
      params.require(:skill).permit(:name, :weight, :description)
    end
end
