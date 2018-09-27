# frozen_string_literal: true

module Api::V1
  class TasksController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Serialize_object

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
      @task.update(task_params)
      render json: serialized_object(@task)
    end

    def destroy
      if Task.destroy(params[:id])
        head :no_content, status: :ok
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    private

    def task_params
      params.require(:task).permit(:name, :text)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end
  end
end