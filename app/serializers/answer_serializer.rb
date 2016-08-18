class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id
  has_many :comments
end
