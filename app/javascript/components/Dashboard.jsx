import React from 'react';
import Card from './Card';

function getWaterEventByPlantId(waterEvents, plantId) {
  return waterEvents
    .filter(waterEvent => {
      if (waterEvent.plant_id == plantId) {
        return waterEvent;
      }
    })
    .shift();
}

function Dashboard({ plants, waterEvents, waterPlant }) {
  return (
    <div className="wrapper">
      {plants.map(plant => {
        return (
          <Card
            key={plant.id}
            plant={plant}
            waterEvent={waterEvents && getWaterEventByPlantId(waterEvents, plant.id)}
            waterPlant={waterPlant}
          />
        );
      })}
    </div>
  );
}

export default Dashboard;
