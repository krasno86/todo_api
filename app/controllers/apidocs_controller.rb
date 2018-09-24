class ApidocsController < ActionController::Base
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Swagger Todo API'
      key :description, 'A sample API that uses rails todo_api'
      contact do
        key :name, 'Krasno Oleg https://github.com/krasno86'
      end
      license do
        key :name, 'MIT'
      end
    end
    tag do
      key :name, 'project'
      key :description, 'project operations'
      externalDocs do
        key :description, 'Find more info here'
        key :url, 'https://swagger.io'
      end
    end
  end

  SWAGGERED_CLASSES = [
      Api::V1::ProjectsController,
      Api::V1::CommentsController,
      Api::V1::TasksController,
      Project,
      User,
      Comment,
      Task,
      self,
  ].freeze

  def index
    render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
  end
end