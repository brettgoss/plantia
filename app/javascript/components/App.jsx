const React     = require('react');
const api       = require('../utils/api');
const Buttons   = require('./Buttons');
const Message   = require('./Message');
const Dashboard = require('./Dashboard');

class App extends React.Component {

  // Sets the state from the props being passed down from the dashboard controller.
  constructor(props) {
    super(props)

    this.handleSubmit = this.handleSubmit.bind(this)
    this.waterAll = this.waterAll.bind(this)
    this.waterOne = this.waterOne.bind(this)

    this.state = {
      plants: this.props.plants,
      waterEvents: this.props.waterEvents,
      messageText: '',
    }
  }

  // Function for watering all plants
  waterAll() {
    api.waterAllPlants()
      .then(function (waterEvents) {
        let messageText = "All your plants have been watered!";
        this.setState({ waterEvents: waterEvents, messageText: messageText });
      }.bind(this))
  }

  // Function for watering individual plants
  waterOne(plantId) {
    api.waterOnePlant(plantId)
      .then(function (waterEvent) {
        let messageText = "Plant Watered!";
        this.setState({ waterEvents: waterEvent, messageText: messageText });
      }.bind(this))
  }

  // Todo:
  // Move waterOne call into this function and implement a way to differentiate
  // between function calls
  handleSubmit() {
    this.waterAll()
  }

  render() {
    console.log('App Rendered')
    return (
      <div>
        <Buttons
          handleSubmit={this.handleSubmit} />
        <Message
          messageText={this.state.messageText} />
        <Dashboard
          waterOne={this.waterOne}
          plants={this.state.plants}
          waterEvents={this.state.waterEvents} />
      </div>
    )
  }

  componentDidMount() {
    console.log("App Mounted")
  }
};

module.exports = App;