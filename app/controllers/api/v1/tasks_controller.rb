# frozen_string_literal: true

module Api::V1
  class TasksController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Swagger::Blocks
    include Serialize_object

    swagger_path '/tasks/:id' do
      operation :get do
        key :summary, 'Find task by ID'
        key :description, 'Returns a single task if the user has access'
        key :operationId, 'findTaskById'
        key :produced, [ 'application/json']
        key :tags, ['tasks']
        parameter do
          key :name, :id
          key :in, :path
          key :description, 'ID of task'
          key :required, true
          key :format, :int64
        end
        response 200 do
          key :description, 'task response'
          schema do
            key :'$ref', :Task
          end
        end
      end
    end

    swagger_path '/tasks' do
      operation :get do
        key :summary, 'All tasks'
        key :description, 'Returns all tasks from the system'
        key :operationId, 'getTask'
        key :produced, [ 'application/json']
        key :tags, ['task']
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
          key :description, 'task response'
          schema do
            key :type, :array
            items do
              key :'$ref', :Task
            end
          end
        end
      end

      operation :post do
        key :description, 'Creates a new task.'
        key :operationId, 'addTask'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'task'
        ]
        parameter do
          key :name, :task
          key :in, :body
          key :description, 'Task'
          key :required, true
          schema do
            key :'$ref', :TaskInput
          end
        end
        response 200 do
          key :description, 'task response'
          schema do
            key :'$ref', :Task
          end
        end
      end

      operation :put do
        key :description, 'Update task in the store.'
        key :operationId, 'updateTask'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'task'
        ]
        parameter do
          key :name, :task
          key :in, :body
          key :description, 'Task to add to the store'
          key :required, true
          schema do
            key :'$ref', :TaskInput
          end
        end
        response 200 do
          key :description, 'task response'
          schema do
            key :'$ref', :Task
          end
        end
      end

      operation :delete do
        key :description, 'Delete task.'
        key :operationId, 'deleteTask'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'task'
        ]
        parameter do
          key :name, :task
          key :in, :body
          key :description, 'Task delete'
          key :required, true
          schema do
            key :'$ref', :TaskInput
          end
        end
        response 200 do
          key :description, 'task response'
          schema do
            key :'$ref', :Task
          end
        end
      end
    end

    before_action :authenticate_user!
    before_action :set_task, only: [:show, :update, :destroy]
    before_action :set_project, only: [:index, :create]

    def index
      @tasks = @project.tasks.all.order("created_at DESC")
      render json: TaskSerializer.new(@tasks).serialized_json, status: 200
    end

    def show
      render json: serialized_object(@task), status: 200
    end

    def create
      @task = @project.tasks.new(task_params)
      if @task.save!
        render json: serialized_object(@task), status: 201
      else
        render json: @task.errors.messages, status: 422
      end
    end

    def update
      if @task.update(task_params)
        render json: serialized_object(@task)
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if Task.destroy
        head :no_content, status: :ok
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    private

    def task_params
      params.require(:task).permit(:name, :deadline, :completed)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end
  end
end