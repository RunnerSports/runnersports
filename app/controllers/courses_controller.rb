class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_course, only:[:edit, :destroy, :update]


  def index
    @courses = Course.available.order(:id).includes(:users)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, notice: "創立成功"
    else
      render :new
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    if @course.update(course_params)
        redirect_to courses_path, notice: "更新成功"
    else
        render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.status = false
    if @course.save
      redirect_to courses_path, notice: "刪除成功"
    end
  end

  private
  def find_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :price, :coach, :course_count, :expiry, :member_limit)
  end

end