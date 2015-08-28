class SessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token
end
