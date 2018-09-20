# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :authenticate_user!
    before_action :set_project, only: [:show, :update, :destroy]

    def index
      @projects = Project.order("created_at DESC")
      render json: @projects, status: 200
    end

    def show
      render json: @projects, status: 200
    end

    def create
      @project = current_user.projects.new(project_params)
      if @project.save!
        render json: @project, status: 201
        # render json: ProjectSerializer.new(@project).serialized_json, status: 201
      else
        render json: @project.errors.messages, status: 422
      end
    end

    def update
      @project.update_attributes(project_params)
      render json: @project
    end

    def destroy
      if @project.destroy
        head :no_content, status: :ok
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    private

    def project_params
      params.require(:project).permit(:name)
    end

    def set_project
      @project = Project.find(params[:id])
    end
  end
end