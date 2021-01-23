class UserCoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_course, only:[:create]

  def index
    @my_courses = UserCourse.includes(:course).where(:user_courses => {:user_id => current_user})
  end

  def create
    @user_course = @course.user_courses.new
    @user_course.user = current_user
    if @user_course.save
      redirect_to courses_path, notice: "報名成功"
    end
  end

  def destroy
    @delete_course = UserCourse.find(params[:id])
    if @delete_course.destroy
      redirect_to user_courses_path, notice: "取消成功"
    end
  end

  private
  def user_course_params
    params.require(:user_course).permit(:course_id, :buy_time, :rest_course_count)
  end

  def find_course
    @course = Course.find(params["course_id"])
  end
end