const React = require('react');
const CardBody = require('./CardBody');
const CardHeader = require('./CardHeader');
const CardFooter = require('./CardFooter');

function waterNext(waterEvent) {
  let num = waterEvent;
  let now = moment();
  let hours = moment.duration(now.diff(num)).asHours();
  let timeToNextWater = Math.floor(1 - hours);
  return timeToNextWater;
}

class Card extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      waterDate: this.props.waterEvent.water_date,
      timeToNextWater: '',
    }

    this.handleSubmit = this.handleSubmit.bind(this)
    this.updateCard = this.updateCard.bind(this)
  }

  componentDidMount() {
    this.updateCard()
  }

  static getDerivedStateFromProps(props, state) {
    if (props.waterEvent.water_date !== state.waterDate) {
      let timeToNextWater = waterNext(props.waterEvent.water_date);

      return {
        waterDate: props.waterEvent.water_date,
        timeToNextWater: timeToNextWater,
      };
    }
    return null;
  }

  // Triggered by the water button onClick, then passes data to the App component
  handleSubmit(e) {
    if (this.props.plant.id > 0) {
      e.preventDefault()
      this.props.waterPlant(this.props.plant.id)
    }
  }

  updateCard() {
    let timeToNextWater = waterNext(this.state.waterDate);
    this.setState({
      timeToNextWater: timeToNextWater,
    })
  }

  render() {
    let plant = this.props.plant;

    return (
      <div key={this.props.plant.index} className="card" >
        <a href={"/plants/" + (plant.id > 0 ? plant.id : 'new')}>
          <CardHeader
            plant={plant}
          />
          <CardBody
            plant={plant}
            waterDate={this.state.waterDate}
            timeToNextWater={this.state.timeToNextWater}
          />
          <CardFooter
            id={plant.id}
            timeToNextWater={this.state.timeToNextWater}
            handleSubmit={this.handleSubmit}
          />
        </a>
      </div>
    )
  }
}

module.exports = Card;