class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :user_id, :votes_count
  has_many :answers
  has_many :comments
  has_many :tags

  def votes_count
  	Vote.count_votes("Question", object)
  end
end
