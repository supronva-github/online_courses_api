# frozen_string_literal: true

module Api
  module V1
    class CompetencesController < ApplicationController
      include ErrorHandler

      before_action :set_competences, only: %i[index]
      before_action :set_competence, only: %i[show update destroy]

      def index
        render json: CompetenceBlueprint.render_as_json(@competences, root: :data)
      end

      def show
        render json: CompetenceBlueprint.render_as_json(@competence, root: :data)
      end

      def create
        @competence = Competence.new(competence_params)
        @competence.save!
        render json: CompetenceBlueprint.render_as_json(@competence, root: :data), status: :created
      end

      def update
        @competence.update!(competence_params)
        render json: CompetenceBlueprint.render_as_json(@competence, root: :data)
      end

      def destroy
        @competence.destroy
        head :no_content
      end

      private

      def set_competences
        @competences = Competence.all
      end

      def set_competence
        @competence = Competence.find(params[:id])
      end

      def competence_params
        params.require(:competence).permit(:name)
      end
    end
  end
end
