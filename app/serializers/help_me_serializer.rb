class HelpMeSerializer < ActiveModel::Serializer
  attributes :id, :user_id
  belongs_to :user
end
