# frozen_string_literal: true

module Api::V1
  class CommentsController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include Swagger::Blocks
    include Serialize_object

    swagger_path '/comments' do
      operation :get do
        key :summary, 'All comments'
        key :description, 'Returns all comments from the system'
        key :operationId, 'getComments'
        key :produced, [ 'application/json']
        key :tags, ['comment']
        parameter do
          key :name, :id
          key :in, :query
          key :description, 'tags to filter by'
          key :required, true
          key :type, :array
          items do
            key :type, :string
          end
          key :collectionFormat, :json
        end
        response 200 do
          key :description, 'comment response'
          schema do
            key :type, :array
            items do
              key :'$ref', :Comment
            end
          end
        end
      end


      operation :post do
        key :description, 'Creates a new comment in the task.  Duplicates are allowed'
        key :operationId, 'addComment'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'comment'
        ]
        parameter do
          key :name, :comment
          key :in, :body
          key :description, 'comment to add to the task'
          key :required, true
          schema do
            key :'$ref', :Commentnput
          end
        end
        response 200 do
          key :description, 'comment response'
          schema do
            key :'$ref', :Comment
          end
        end
      end

      operation :put do
        key :description, 'Update comment in the task.'
        key :operationId, 'updateComment'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'comment'
        ]
        parameter do
          key :name, :comment
          key :in, :body
          key :description, 'Comment to add to the task'
          key :required, true
          schema do
            key :'$ref', :ProjectInput
          end
        end
        response 200 do
          key :description, 'Comment response'
          schema do
            key :'$ref', :Comment
          end
        end
      end

      operation :delete do
        key :description, 'Delete comment in the task.'
        key :operationId, 'deleteComment'
        key :produces, [
            'application/json'
        ]
        key :tags, [
            'comment'
        ]
        parameter do
          key :name, :comment
          key :in, :body
          key :description, 'Comment to add to the store'
          key :required, true
          schema do
            key :'$ref', :CommentInput
          end
        end
        response 200 do
          key :description, 'comment response'
          schema do
            key :'$ref', :Comment
          end
        end
      end
    end

    before_action :authenticate_user!
    before_action :set_task, only: [:index, :create]

    def index
      @comments = @task.comments.order("created_at ASC")
      render json: CommentSerializer.new(@comments).serialized_json, status: 200
    end

    def create
      @comment = @task.comments.new(comment_params.merge(user_id: current_user.id))
      if @comment.save!
        render json: serialized_object(@comment), status: 201
      else
        render json: @task.errors.messages, status: 422
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
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
      @task = Task.find(params[:task_id])
    end
  end
end