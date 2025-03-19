# frozen_string_literal: true

class CourseReassignmentService
  def initialize(user)
    @user = user
  end

  def call
    return true unless user_has_courses?

    reassign_courses_to_random_user
    true
  end

  private

  def user_has_courses?
    @user.owner_cources.any?
  end

  def reassign_courses_to_random_user
    @user.owner_cources.update_all(author_id: random_user_id)
  end

  def random_user_id
    User.where.not(id: @user.id).pluck(:id).sample
  end
end
