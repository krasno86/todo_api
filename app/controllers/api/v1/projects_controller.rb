# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Swagger::Blocks
    include Serialize_object

    before_action :authenticate_user!
    before_action :set_project, only: [:show, :update, :destroy]

    swagger_path '/projects/{id}' do
      operation :get do
        key :description, 'Returns a single project if the user has access'
        key :operationId, 'findProjectById'
        key :produced, [ 'application/json']
        key :tags, ['projects']
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of project'
          key :required, true
          key :type, :integer
          key :format, :int64
        end
        response 200 do
          key :description, 'project response'
          schema do
            key :'$ref', :ProjectResponse
          end
        end
        response :default do
          key :description, 'unexpected error'
          schema do
            key :'$ref', :ErrorModel
          end
        end
      end
    end

    swagger_path '/projects' do
      operation :get do
        key :description, 'Get All projects'
        key :operationId, 'getProject'
        key :produced, [ 'application/json']
        key :tags, ['projects']
        response 200 do
          key :description, 'All projects'
          schema do
            key :'$ref', :ProjectsResponse
          end
        end
      end
    end

    def index
      @projects = current_user.projects.all.order("created_at DESC")
      render json: serialized_object(@projects), status: 200
    end

    def show
      render json: serialized_object(@project), status: 200
    end

    def create
      @project = current_user.projects.new(project_params)
      if @project.save!
        render json: serialized_object(@project), status: 201
      else
        render json: @project.errors.messages, status: 422
      end
    end

    def update
      @project.update_attributes(project_params)
      render json: serialized_object(@project)
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