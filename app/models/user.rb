class User < ApplicationRecord
  has_many :owner_cources, class_name: 'Course', foreign_key: :author_id

  before_destroy :reassign_courses

  private

  def reassign_courses
    CourseReassignmentService.new(self).call
  end
end
