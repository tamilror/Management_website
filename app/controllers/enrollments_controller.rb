class EnrollmentsController < ApplicationController
    def create
      # Assuming user is already authenticated
      course = Course.find(params[:course_id])
      enrollment = current_user.enrollments.build(course: course)
      
      if enrollment.save
        # Publish to RabbitMQ
        publish_enrollment_request(enrollment)
        redirect_to course_path(course), notice: 'Enrollment request sent.'
      else
        redirect_to course_path(course), alert: 'Could not process enrollment.'
      end
    end
  
    private
  
    def publish_enrollment_request(enrollment)
      connection = Bunny.new(ENV['CLOUDAMQP_URL'])
      connection.start
      channel = connection.create_channel
      queue = channel.queue('enrollment_requests')
      queue.publish(enrollment.to_json)
      connection.close
    end
  end
  