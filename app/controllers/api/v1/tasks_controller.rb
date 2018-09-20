# frozen_string_literal: true

module Api::V1
  class TasksController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken

    before_action :authenticate_user!
    before_action :set_task, only: [:show, :update, :destroy]

    def index; end

  end
end