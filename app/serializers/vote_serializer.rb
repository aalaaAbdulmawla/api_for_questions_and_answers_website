class VoteSerializer < ActiveModel::Serializer
  attributes :user_id, :votable_id, :votable_type, :up_flag, :created_at, :updated_at
end
