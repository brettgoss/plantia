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
  waterAll(){
    api.postWaterAll()
      .then(function (waterEvents) {
        $(".message0").text("All your plants have been watered!");
        $(".message0").show().delay(1500).fadeOut();

        this.setState(function () {
          return {
            water: waterEvents
          }
        });
      }.bind(this))
  }

  // Function for watering individual plants
  waterOne(plantId){
    $.ajax({
      url: '/water_events',
      type: "POST",
      data: {plant_id: plantId}
    }).done((water) => {
      $(".message0").text("Plant Watered!");
      $(".message0").show().delay(1500).fadeOut();
      this.setState({water: water});
    });
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