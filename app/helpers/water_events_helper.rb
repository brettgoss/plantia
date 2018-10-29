module WaterEventsHelper
  def create_water_event(plant)
    water_event = WaterEvent.new({plant_id: plant.id})
    water_event.water_date = DateTime.now + plant.water_freq.days
    water_event.save
  end
end
