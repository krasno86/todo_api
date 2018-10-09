# frozen_string_literal: true

class User < ActiveRecord::Base
  include Swagger::Blocks

  swagger_schema :User do
    key :required, [:id, :email, :password, :password_confirmation]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :email do
      key :type, :string
    end
    property :password do
      key :type, :string
    end
    property :password_confirmation do
      key :type, :string
    end
  end

  swagger_schema :UserInput do
    allOf do
      schema do
        key :'$ref', :User
      end
      schema do
        key :required, [:email]
        key :required, [:password]
        key :required, [:password_confirmation]
        property :id do
          key :type, :integer
          key :format, :int64
        end
      end
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  before_save :downcase_email

  def set_default_role
    self.role ||= :user
  end

  has_many :projects, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  private

  def downcase_email
    self.email = self.email.delete(' ').downcase
  end
end
