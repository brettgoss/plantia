import React from 'react';

// TODO: Should be saving the last waterEvent rather than the next one
//       since this is needlessly complicated as a result
function getLastWatered(waterEvent, waterFreq) {
  return moment(waterEvent)
    .subtract(waterFreq, 'days')
    .format('lll');
}

function getWaterFreqString(waterFreq) {
  return waterFreq === 1 ? '1 day' : `${waterFreq} days`;
}

function getWaterNextString(timeToNextWater) {
  const countdown = Math.floor(timeToNextWater / 24);

  return timeToNextWater >= 48
    ? `Water in ${countdown} days`
    : timeToNextWater >= 24
    ? `Water in ${countdown} day`
    : timeToNextWater > 1
    ? `Water in ${timeToNextWater} hours`
    : `Your plant is thirsty!`;
}

function CardBody({ waterDate, plant, timeToNextWater }) {
  const lastWaterEvent = getLastWatered(waterDate, plant.water_freq);
  const waterNextString = getWaterNextString(timeToNextWater);
  const waterFrequency = getWaterFreqString(plant.water_freq);

  return (
    <div className="plant-content">
      <h5 className="plant-details">{waterNextString}</h5>
      <div className="card-info">Last Watered</div>
      <div className="plant-details">{lastWaterEvent}</div>
      <div className="card-info">Needs</div>
      <div className="plant-details">Watering every {waterFrequency}</div>
      <div className="plant-details">{plant.light}</div>
    </div>
  );
}

export default CardBody;
