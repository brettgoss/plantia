const React     = require('react');
const api       = require('../utils/api');
const Buttons   = require('./Buttons');
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
      water: this.props.water
    }
  }

  // Function for watering all plants
  waterAll() {
    api.postWaterAll()
      .then(function (waterEvents) {
        $(".message").text("All your plants have been watered!");
        $(".message").show().delay(1500).fadeOut();

        this.setState({ water: waterEvents });
      }.bind(this))
  }

  // Function for watering individual plants
  waterOne(plantId) {
    api.postWaterOne(plantId)
      .then(function (waterEvent) {
        $(".message").text("Plant Watered!");
        $(".message").show().delay(1500).fadeOut();

        this.setState({ water: waterEvent });
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
        <Buttons handleSubmit={this.handleSubmit} />
        <Dashboard
          waterOne={this.waterOne}
          plants={this.state.plants}
          water={this.state.water} />
      </div>
    )
  }

  componentDidMount() {
    console.log("App Mounted")
  }
};

module.exports = App;