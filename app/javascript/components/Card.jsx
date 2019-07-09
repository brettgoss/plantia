import React from 'react';

import CardBody from './CardBody';
import CardHeader from './CardHeader';
import CardFooter from './CardFooter';

function getNextWaterDate(waterEvent) {
  const hours = moment.duration(moment().diff(waterEvent)).asHours();

  return Math.floor(1 - hours);
}

function Card({ waterEvent: { water_date: waterDate }, plant, waterPlant }) {
  const timeToNextWater = getNextWaterDate(waterDate);

  const handleSubmit = e => {
    // This can be called by the placeholder plant card
    if (plant.id) {
      e.preventDefault();
      waterPlant(plant.id);
    }
  };

  return (
    <div key={plant.index} className="card">
      <a href={'/plants/' + (plant.id > 0 ? plant.id : 'new')}>
        <CardHeader plant={plant} />
        <CardBody
          plant={plant}
          waterDate={waterDate}
          timeToNextWater={timeToNextWater}
        />
        <CardFooter
          id={plant.id}
          timeToNextWater={timeToNextWater}
          handleSubmit={(e) => handleSubmit(e)}
        />
      </a>
    </div>
  );
}

export default Card;
