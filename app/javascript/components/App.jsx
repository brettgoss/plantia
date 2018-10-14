const React     = require('react');
const api       = require('../utils/api');
const Buttons   = require('./Buttons');
const Message   = require('./Message');
const Dashboard = require('./Dashboard');

class App extends React.Component {

  // Sets the state from the props being passed down from the dashboard controller.
  constructor(props) {
    super(props)

    this.waterPlants = this.waterPlants.bind(this)

    this.state = {
      plants: this.props.plants,
      waterEvents: this.props.waterEvents,
      messageText: '',
    }
  }


  waterPlants(plantId) {
    if (plantId.length) {
      api.waterOnePlant(plantId)
        .then(function (waterEvent) {
          let messageText = "Plant Watered!";
          this.setState({ waterEvents: waterEvent, messageText: messageText });
        }.bind(this))
    } else {
      api.waterAllPlants()
        .then(function (waterEvents) {
          let messageText = "All your plants have been watered!";
          this.setState({ waterEvents: waterEvents, messageText: messageText });
        }.bind(this))
    }
  }

  render() {
    console.log('App Rendered')
    return (
      <div>
        <Buttons
          waterPlants={this.waterPlants} />
        <Message
          messageText={this.state.messageText} />
        <Dashboard
          plants={this.state.plants}
          waterEvents={this.state.waterEvents}
          waterPlant={this.waterPlants}
        />
      </div>
    )
  }

  componentDidMount() {
    console.log("App Mounted")
  }
};

module.exports = App;