module Serialize_object
  extend ActiveSupport::Concern

  def serialized_object(object)
    ProjectSerializer.new(object).serialized_json
  end
end
