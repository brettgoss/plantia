class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :name, :email, :uuid, :created_at, :updated_at

  has_many :plants, serializer: Api::V1::PlantSerializer do
    include_data(false)
    link(:related) { api_v1_plants_path(user_id: object.id) }
  end

  has_many :subscriptions do
    include_data(false)
    link(:related) { api_v1_users_path(user_id: object.id) }
  end

  def created_at
    object.created_at.in_time_zone.iso8601 if object&.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object&.created_at
  end
end