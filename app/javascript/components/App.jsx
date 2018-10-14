const React     = require('react');
const api       = require('../utils/api');
const Buttons   = require('./Buttons');
const Message   = require('./Message');
const Dashboard = require('./Dashboard');

class App extends React.Component {

  // Sets the state from the props being passed down from the dashboard controller.
  constructor(props) {
    super(props)

    this.handlePlantWatering = this.handlePlantWatering.bind(this)

    this.state = {
      plants: this.props.plants,
      waterEvents: this.props.waterEvents,
      messageText: '',
    }
  }

  handlePlantWatering (plantId) {
    let messageText = ''
    plantId.length
      ? messageText = "Plant Watered!"
      : messageText = "All your plants have been watered!"

    this.waterPlants(plantId)
      .then((response) => {
        this.setState({
          waterEvents: response,
          messageText: messageText,
        });
      })
  }

  waterPlants(plantId) {
    if (plantId.length) {
      return api.waterOnePlant(plantId)
        .then(function (waterEvent) {
          return waterEvent;
        })
    } else {
      return api.waterAllPlants()
        .then(function (waterEvents) {
          return waterEvents;
        })
    }
  }

  render() {
    console.log('App Rendered')
    return (
      <div>
        <Buttons
          waterPlants={this.handlePlantWatering} />
        <Message
          messageText={this.state.messageText} />
        <Dashboard
          plants={this.state.plants}
          waterEvents={this.state.waterEvents}
          waterPlant={this.handlePlantWatering}
        />
      </div>
    )
  }

  componentDidMount() {
    console.log("App Mounted")
  }
};

module.exports = App;