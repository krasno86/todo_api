# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :projects
  has_many :comments

  validates :username, presence: true, length: { minimum: 3,
                                                 too_short: "%{count} characters is the minimum allowed",
                                                 maximum: 50,
                                                 too_long: "%{count} characters is the maximum allowed" }
  validates :password, confirmation: true, presence: true
  validates :password_confirmation, presence: true
end
