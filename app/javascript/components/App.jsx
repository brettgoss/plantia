const React     = require('react');
const api       = require('../utils/api');
const ButtonBar = require('./Buttons');
const Message   = require('./Message');
const Dashboard = require('./Dashboard');

function waterPlants (plantId) {
  if (plantId > 0) {
    return api.waterOnePlant(plantId)
      .then((waterEvents) => {
        return waterEvents;
      })
  } else {
    return api.waterAllPlants()
      .then((waterEvents) => {
        return waterEvents;
      })
  }
}

class App extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      waterEvents: this.props.waterEvents,
      messageText: '',
    }

    this.handlePlantWatering = this.handlePlantWatering.bind(this)
  }

  handlePlantWatering (plantId) {
    let messageText = (plantId > 0)
      ? "Plant Watered!"
      : "All your plants have been watered!"

    waterPlants(plantId)
      .then((response) => {
        this.setState({
          waterEvents: response,
          messageText: messageText,
        })
      })
  }

  render() {
    return (
      <React.Fragment>
        <ButtonBar
          waterPlants={this.handlePlantWatering} />
        <Message
          messageText={this.state.messageText} />
        <Dashboard
          plants={this.props.plants}
          waterEvents={this.state.waterEvents}
          waterPlant={this.handlePlantWatering}
        />
      </React.Fragment>
    )
  }
};

module.exports = App;