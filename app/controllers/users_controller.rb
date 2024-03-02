
class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to login_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end

    def my_courses
        @enrollments = current_user.enrollments.includes(:course)
      end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :role)
    end
  end
  