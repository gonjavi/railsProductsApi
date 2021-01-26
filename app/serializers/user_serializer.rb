class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :last_name
end
