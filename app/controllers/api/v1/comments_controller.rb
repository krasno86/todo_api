# frozen_string_literal: true

module Api::V1
  class CommentsController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Serialize_object

    before_action :authenticate_user!
    before_action :set_task, only: [:index, :create]

    def index
      @comments = @task.comments.order("created_at DESC")
      render json: serialized_object(@comments), status: 200
    end

    def create
      @comment = @task.comments.new(comment_params)
      if @task.save!
        render json: serialized_object(@comment), status: 201
      else
        render json: @task.errors.messages, status: 422
      end
    end

    def destroy
      if Comment.destroy(params[:id])
        head :no_content, status: :ok
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:file, :text)
    end

    def set_task
      @task = Task.find(params[:id])
    end
  end
end