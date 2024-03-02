class CouresController < ApplicationController
def index
    @courses = case current_user.role
               when 'admin', 'super_admin'
                 Course.all
               when 'instructor'
                 current_user.courses
               else
                 Course.includes(:enrollments).where(enrollments: { user_id: current_user })
               end
               
def create
    @course = Course.new(course_params)
     if @course.save
        redirect_to courses_path, notice: 'Course was successfully created.'
    else
        render :new
    end
 end
              
private           
 def course_params
     params.require(:course).permit(:title, :description, :instructor_id)
 end            
end
end