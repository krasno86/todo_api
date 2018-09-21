# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :projects
  has_many :comments

  validates :username, length: { minimum: 3,
                                 too_short: "%{count} characters is the minimum allowed",
                                 maximum: 50,
                                 too_long: "%{count} characters is the maximum allowed" },
                                 uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, presence: true
  validates :password_confirmation, presence: true

  attr_writer :login

  # def login
  #   @login || self.username || self.email
  # end
  #
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
  #   elsif conditions.has_key?(:username) || conditions.has_key?(:email)
  #     where(conditions.to_h).first
  #   end
  # end
  def email_required?
    false
  end

  def email_changed?
    false
  end

  # use this instead of email_changed? for Rails = 5.1.x
  def will_save_change_to_email?
    false
  end
end
