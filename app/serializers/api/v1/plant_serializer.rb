class Api::V1::PlantSerializer < Api::V1::BaseSerializer
  attributes(*Plant.attribute_names.map(&:to_sym))
  has_many :water_events
end