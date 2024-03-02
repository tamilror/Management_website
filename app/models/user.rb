class User < ApplicationRecord
  has_secure_password
  enum role: { student: 0, instructor: 1, admin: 2, super_admin: 3 }
  # Associations
  has_many :courses, foreign_key: :instructor_id
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
end
