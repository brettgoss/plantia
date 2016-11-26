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

  waterAll(){
    $.ajax({
      url: '/waterall',
      type: "POST"
    }).done((water) => {
      $(".message0").text("All your plants have been watered!");
      $(".message0").show().delay(1000).fadeOut();
      this.setState({water: water});
    });
  }
  waterOne(plantId){
    console.log('Plant ' + plantId + ' attempting to water')
    $.ajax({
      url: '/water_events',
      type: "POST",
      data: {plant_id: plantId}
    }).done((water) => {
      console.log('Plant ' + water.plant_id + ' successfully watered')
      $(".message0").text("Plant Watered");
      $(".message0").show().delay(1000).fadeOut();
      this.setState({water: water});
    });
  }

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
    console.log("App mounted")
  }
};
