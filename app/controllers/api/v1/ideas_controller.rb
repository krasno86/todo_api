module Api::V1
  class ProjectsController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :authenticate_user!

    def index
      @projects = Project.order("created_at DESC")
      render json: @projects
    end

    def create
      @project = Project.create(idea_params)
      render json: @project
    end

    def update
      @project = Project.find(params[:id])
      @project.update_attributes(idea_params)
      render json: @project
    end

    def destroy
      @project = Project.find(params[:id])
      if @project.destroy
        head :no_content, status: :ok
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end

    private

    def project_params
      params.require(:project).permit(:title, :body)
    end
  end
end