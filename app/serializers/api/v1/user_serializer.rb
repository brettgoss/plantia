class Api::V1::UserSerializer < Api::V1::BaseSerializer
  attributes :uuid, :name, :email, :created_at, :updated_at

  has_many :plants
  has_many :water_events, through: :plants
  has_many :subscriptions

  def created_at
    object.created_at.in_time_zone.iso8601 if object&.created_at
  end

  def updated_at
    object.updated_at.in_time_zone.iso8601 if object&.created_at
  end
end