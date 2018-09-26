class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email

  has_many :projects
  has_many :comments
end
