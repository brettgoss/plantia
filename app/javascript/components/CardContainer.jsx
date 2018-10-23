const React = require('react');
const CardBody = require('./Card');
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
  handleSubmit() {
    this.props.waterPlant(this.props.plant.id)
  }

  updateCard() {
    let timeToNextWater = waterNext(this.state.waterDate);
    this.setState({
      timeToNextWater: timeToNextWater,
    })
  }

  render() {
    return (
      <div key={this.props.plant.index} className="card" >
        <a href={"/plants/" + this.props.plant.id}>
          <CardHeader
            plant={this.props.plant}
          />
          <CardBody
            plant={this.props.plant}
            waterDate={this.state.waterDate}
            timeToNextWater={this.state.timeToNextWater}
          />
        </a>
        <CardFooter
          timeToNextWater={this.state.timeToNextWater}
          handleSubmit={this.handleSubmit}
        />
      </div>
    )
  }
}

module.exports = Card;