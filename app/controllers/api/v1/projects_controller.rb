# frozen_string_literal: true

module Api::V1
  class ProjectsController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Swagger::Blocks
    include Serialize_object

    swagger_path '/projects/:id' do
      operation :get do
        key :summary, 'Find Project by ID'
        key :description, 'Returns a single project if the user has access'
        key :operationId, 'findProjectById'
        key :produced, [ 'application/json']
        key :tags, ['projects']
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of project'
          key :required, true
          key :format, :int64
        end
        response 200 do
          key :description, 'project response'
          schema do
            key :'$ref', :Project
          end
        end
      end
    end

    swagger_path '/projects' do
      operation :get do
        key :summary, 'All projects'
        key :description, 'Returns all projects from the system'
        key :operationId, 'getProject'
        key :produced, [ 'application/json']
        key :tags, ['project']
        parameter do
          key :name, :id
          key :in, :query
          key :description, 'tags to filter by'
          key :required, false
          key :type, :array
          items do
            key :type, :string
          end
          key :collectionFormat, :csv
        end
        response 200 do
          key :description, 'project response'
          schema do
            key :type, :array
            items do
              key :'$ref', :Project
            end
          end
        end
      end

      operation :post do
        key :description, 'Creates a new project.'
        key :operationId, 'addProject'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'project'
        ]
        parameter do
          key :name, :project
          key :in, :body
          key :description, 'Project'
          key :required, true
          schema do
            key :'$ref', :ProjectInput
          end
        end
        response 200 do
          key :description, 'project response'
          schema do
            key :'$ref', :Project
          end
        end
      end

      operation :put do
        key :description, 'Update project in the store.'
        key :operationId, 'updateProject'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'project'
        ]
        parameter do
          key :name, :project
          key :in, :body
          key :description, 'Project to add to the store'
          key :required, true
          schema do
            key :'$ref', :ProjectInput
          end
        end
        response 200 do
          key :description, 'project response'
          schema do
            key :'$ref', :Project
          end
        end
      end

      operation :delete do
        key :description, 'Delete project.'
        key :operationId, 'deleteProject'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'project'
        ]
        parameter do
          key :name, :project
          key :in, :body
          key :description, 'Project delete'
          key :required, true
          schema do
            key :'$ref', :ProjectInput
          end
        end
        response 200 do
          key :description, 'project response'
          schema do
            key :'$ref', :Project
          end
        end
      end
    end

    before_action :authenticate_user!
    before_action :set_project, only: [:show, :update, :destroy]

    def index
      @projects = current_user.projects.all.order("created_at DESC")
      render json: ProjectSerializer.new(@projects).serialized_json, status: 200
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
      if @project.update_attributes(project_params)
        render json: serialized_object(@project)
      else
        render json: @project.errors, status: :unprocessable_entity
      end
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