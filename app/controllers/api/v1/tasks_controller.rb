# frozen_string_literal: true

module Api::V1
  class TasksController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :authenticate_user!
    before_action :set_task, only: [:show, :update]
    before_action :set_project, only: [:index, :create, :destroy]

    def index
      @tasks = @project.tasks.all.order("created_at DESC")
      render json: @tasks, status: 200
    end

    def show
      render json: @task, status: 200
    end

    def create
      @task = @project.tasks.new(task_params)
      if @task.save!
        render json: @task, status: 201
        # render json: ProjectSerializer.new(@project).serialized_json, status: 201
      else
        render json: @task.errors.messages, status: 422
      end
    end

    def update
      @task.update(task_params)
      render json: @task
    end

    def destroy
      p params
      p current_user
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