const React     = require('react');
const api       = require('../utils/api');
const ButtonBar = require('./Buttons');
const Message   = require('./Message');
const Dashboard = require('./Dashboard');

class App extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      plants: this.props.plants,
      waterEvents: this.props.waterEvents,
      messageText: '',
    }

    this.handlePlantWatering = this.handlePlantWatering.bind(this)
  }

  waterPlants(plantId) {
    if (plantId.length) {
      return api.waterOnePlant(plantId)
        .then((waterEvent) => {
          return waterEvent;
        })
    } else {
      return api.waterAllPlants()
        .then((waterEvents) => {
          return waterEvents;
        })
    }
  }

  handlePlantWatering (plantId) {
    let messageText = (plantId.length)
      ? "Plant Watered!"
      : "All your plants have been watered!"

    this.waterPlants(plantId)
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
          plants={this.state.plants}
          waterEvents={this.state.waterEvents}
          waterPlant={this.handlePlantWatering}
        />
      </React.Fragment>
    )
  }
};

module.exports = App;