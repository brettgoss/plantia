class Api::V1::PlantSerializer < Api::V1::BaseSerializer
  attributes(*Plant.attribute_names.map(&:to_sym))
  has_many :water_events, if: :include_water_events?
  has_many :plantlogs, if: :include_plantlogs?

  def include_water_events?
    @instance_options[:included].include? 'water_events'
  end

  def include_plantlogs?
    @instance_options[:included].include? 'plantlogs'
  end
end
