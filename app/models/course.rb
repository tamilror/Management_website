class Course < ApplicationRecord
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id'
  has_many :enrollments
  has_many :students, through: :enrollments, source: :user
end
