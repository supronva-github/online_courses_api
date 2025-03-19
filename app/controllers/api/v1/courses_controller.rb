# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      include ErrorHandler

      before_action :set_courses, only: %i[index]
      before_action :set_course, only: %i[show update destroy]

      def index
        render json: CourseBlueprint.render_as_json(@courses, root: :data)
      end

      def show
        render json: CourseBlueprint.render_as_json(@course, root: :data)
      end

      def create
        @course = Course.new(course_params)
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
          :author_id,
          competence_ids: []
        )
      end
    end
  end
end
