class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :generate_lessons]

  def index
    @courses = Course.all
  end

  def generate_lessons
    @course.lessons.where("start > ?", Time.now).destroy_all
    @course.schedule.next_occurrences(8).each do |occurrence|
      @course.lessons.find_or_create_by(start: occurrence, user: @course.user, classroom: @course.classroom)
    end
    @course.lessons.where("start > ?", Time.now).each do |lesson|
      @course.enrollments.each do |enrollment|
        lesson.attendances.find_or_create_by(status: "planned", user: enrollment.user)
      end
    end

    redirect_to @course, notice: "generate_lessons - ok"
  end

  def show
    @lessons = @course.lessons
    @enrollments = @course.enrollments
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:user_id, :classroom_id, :service_id, :start_time, 
        *Course::DAYS_OF_WEEK,
        enrollments_attributes: [:id, :user_id, :_destroy])
    end
end
