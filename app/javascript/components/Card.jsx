const React = require('react');

// Calculation for how many days until the plant needs to be watered
// based on the provided water frequency and the most recent waterEvent
// TODO: Why is the waterFreq being used here?
function lastWatered(waterEvent, waterFreq) {
  let num = moment(waterEvent);
  let freq = moment.duration(waterFreq, 'days').asHours();
  let result = moment(num).subtract(freq, 'hours').format('lll');
  return result;
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

function CardBody (props) {
  const lastWaterEvent = lastWatered(props.waterDate, props.plant.water_freq);
  const waterNextString = getWaterNextString(props.timeToNextWater);
  const waterFrequency = (props.plant.water_freq === 1) ? "1 day" : `${props.plant.water_freq} days`;
  {/* Plant card body */ }
  return (
    <div className="plant-content">
      <h5 className="plant-details">{waterNextString}</h5>
      <div className="card-info">Last Watered</div>
      <div className="plant-details">{lastWaterEvent}</div>
      <div className="card-info">Needs</div>
      <div className="plant-details">Watering every {waterFrequency}</div>
      <div className="plant-details">{props.plant.light}</div>
    </div>
  )
}

function waterNext(waterEvent) {
  let num = waterEvent;
  let now = moment();
  let hours = moment.duration(now.diff(num)).asHours();
  return Math.floor(1 - hours);
}

function getPlantHealth(timeToNextWater) {
  if (timeToNextWater >= 24) return plantHealth = 'good';
  if (timeToNextWater >= 1) return plantHealth = 'trouble';
  return plantHealth = 'bad';
}

class Card extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      waterDate: this.props.waterEvent.water_date,
      timeToNextWater: '',
      plantHealth: '',
    }

    this.handleSubmit = this.handleSubmit.bind(this)
    this.updateCard = this.updateCard.bind(this)
  }

  componentDidMount() {
    this.updateCard()
  }

  // Triggered by the water button onClick, then passes data to the App component
  handleSubmit() {
    this.props.waterPlant(this.props.plant.id)
  }

  updateCard() {
    let timeToNextWater = waterNext(this.state.waterDate);
    let plantHealth = getPlantHealth(timeToNextWater);
    this.setState({
      timeToNextWater: timeToNextWater,
      plantHealth: plantHealth,
    })
  }

  static getDerivedStateFromProps(props, state) {
    if (props.waterEvent.water_date !== state.waterDate) {
      let timeToNextWater = waterNext(props.waterEvent.water_date);
      let plantHealth = getPlantHealth(timeToNextWater);

      return {
        waterDate: props.waterEvent.water_date,
        timeToNextWater: timeToNextWater,
        plantHealth: plantHealth,
      };
    }
    return null;
  }

  render() {
    const plant = this.props.plant;

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
          <CardBody
            plant={plant}
            waterDate={this.state.waterDate}
            timeToNextWater={this.state.timeToNextWater}
            plantHealth={this.state.plantHealth}
          />
        </a>
        {/* Plant Water Button */}
        <input
          id={plant.id}
          type="button"
          value={"Water"}
          className={"card-button card-button-" + this.state.plantHealth}
          onClick={this.handleSubmit} />
      </div>
    )
  }
}

module.exports = Card;