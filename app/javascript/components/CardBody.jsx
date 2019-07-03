import React, { Component } from 'react';

// Calculation for how many days until the plant needs to be watered
// based on the provided water frequency and the most recent waterEvent
// TODO: Why is the waterFreq being used here?
function lastWatered(waterEvent, waterFreq) {
  let num = moment(waterEvent);
  let freq = moment.duration(waterFreq, 'days').asHours();
  let result = moment(num).subtract(freq, 'hours').format('lll');
  return result;
}

function getWaterNextString(timeToNextWater) {
  let countdown = Math.floor(timeToNextWater / 24);

  if (timeToNextWater >= 48) {
    return `Water in ${countdown} days`;
  } else if (timeToNextWater >= 24) {
    return `Water in ${countdown} day`;
  } else if (timeToNextWater > 1) {
    return `Water in ${timeToNextWater} hours`;
  } else {
    return `Your plant is thirsty!`;
  }
}

class CardBody extends Component {
  render() {
    let lastWaterEvent  = lastWatered(this.props.waterDate, this.props.plant.water_freq);
    let waterNextString = getWaterNextString(this.props.timeToNextWater);
    let waterFrequency  = (this.props.plant.water_freq === 1) ? "1 day" : `${this.props.plant.water_freq} days`;

    return (
      <div className="plant-content">
        <h5 className="plant-details">{waterNextString}</h5>
        <div className="card-info">Last Watered</div>
        <div className="plant-details">{lastWaterEvent}</div>
        <div className="card-info">Needs</div>
        <div className="plant-details">Watering every {waterFrequency}</div>
        <div className="plant-details">{this.props.plant.light}</div>
      </div>
    )
  }
}

export default CardBody;