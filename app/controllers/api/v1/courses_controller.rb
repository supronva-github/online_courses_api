# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_courses, only: %i[index]
      before_action :set_course, only: %i[show update destroy]
      before_action :doorkeeper_authorize!, except: %i[index show]
      before_action :verify_author!, only: %i[update destroy]

      def index
        render json: CourseBlueprint.render_as_json(@courses, root: :data)
      end

      def show
        render json: CourseBlueprint.render_as_json(@course, root: :data)
      end

      def create
        @course = current_user.owner_courses.new(course_params)
        @course.save!

        render json: CourseBlueprint.render_as_json(@course, root: :data), status: :created
      end

      def update
        @course.update!(course_params)
        render json: CourseBlueprint.render_as_json(@course, root: :data)
      end

      def destroy
        @course.destroy
        head :no_content
      end

      private

      def set_courses
        @courses = Course.all
      end

      def set_course
        @course = Course.find(params[:id])
      end

      def course_params
        params.require(:course).permit(
          :title,
          :description,
          competence_ids: []
        )
      end

      def current_user
        @current_user ||= User.find_by(id: doorkeeper_token&.resource_owner_id)
      end

      def verify_author!
        return if current_user&.author_of?(@course)

        handle_forbidden_access
      end
    end
  end
end
