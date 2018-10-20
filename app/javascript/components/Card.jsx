const React = require('react');

// Calculation for how many days until the plant needs to be watered
// based on the provided water frequency and the most recent waterEvent
function lastWatered(waterEvent, waterFreq) {
  let num = moment(waterEvent);
  let freq = moment.duration(waterFreq, 'days').asHours();
  let result = moment(num).subtract(freq, 'hours').format('lll')
  return result;
}

function waterNext(waterEvent) {
  let num = waterEvent;
  let now = moment();
  let hours = moment.duration(now.diff(num)).asHours();
  return Math.floor(1 - hours);
}

function getWaterNextString (timeToNextWater) {
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

function getPlantHealth(timeToNextWater) {
  if (timeToNextWater >= 24) return plantHealth = 'good';
  if (timeToNextWater >= 1)  return plantHealth = 'trouble';
  return plantHealth = 'bad';
}

function getWaterEventByPlantId(waterEvents, plantId) {
  return waterEvents.filter((waterEvent) => {
    if (waterEvent.plant_id == plantId) {
      return waterEvent;
    }
  }).shift()
}

class Card extends React.Component {
  constructor(props) {
    super(props)

    this.handleSubmit = this.handleSubmit.bind(this)
  }

  // Triggered by the water button onClick, then passes data to the App component
  handleSubmit() {
    this.props.waterPlant(this.props.plant.id)
  }

  render() {
    const plant = this.props.plant;
    const waterEvent = getWaterEventByPlantId(this.props.waterEvents, plant.id)
    const timeToNextWater = waterNext(waterEvent.water_date);
    const lastWaterEvent = lastWatered(waterEvent.water_date, plant.water_freq);
    const plantHealth = getPlantHealth(timeToNextWater);
    const waterNextString = getWaterNextString(timeToNextWater)
    const waterFrequency = (plant.water_freq === 1) ? "1 day" : `${plant.water_freq} days`;

    return (
      <div key={plant.index} className="card" >
        {/* Plant card header */}
        <a href={"/plants/" + plant.id}>
          <header className="plant-header">
            <img className="plant-image" src="/favicon.ico"/>
            <div className="plant-head">
              <div className="plant-nickname">{plant.nickname}</div>
              <div className="plant-common">{plant.common_name}</div>
            </div>
          </header>
          {/* Plant card body */}
          <div className="plant-content">
            <h5 className="plant-details">{waterNextString}</h5>
            <div className="card-info">Last Watered</div>
              <div className="plant-details">{lastWaterEvent}</div>
            <div className="card-info">Needs</div>
              <div className="plant-details">Watering every {waterFrequency}</div>
              <div className="plant-details">{plant.light}</div>
          </div>
        </a>
        {/* Plant Water Button */}
        <input
          id={plant.id}
          type="button"
          value={"Water"}
          className={"card-button card-button-" + plantHealth}
          onClick={this.handleSubmit} />
      </div>
    )
  }
}

module.exports = Card;