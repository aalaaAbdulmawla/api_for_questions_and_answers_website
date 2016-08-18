class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name,:last_name, :job, :location, :birth_date, :about, :created_at, :updated_at
end
