class App extends React.Component {

  // Sets the state from the props being passed down from the dashboard controller.
  constructor(props) {
    super(props)

    this.handleSubmit = this.handleSubmit.bind(this)
    this.handleEvents = this.handleEvents.bind(this)
    this.state = {
      plants: this.props.plants,
      water: this.props.water
    }
  }

  handleEvents(water){
    console.log('Event', this.props.water)
    console.log('Event2', water)

    this.setState({water: water});
  }

  handleSubmit() {
    $.ajax({
      url: '/waterall',
      type: "POST"
    }).done((water) => {
      $(".message0").text("All your plants have been watered!");
      $(".message0").show().delay(1000).fadeOut();
      // console.log('Ajax', water)
      this.handleEvents(water)
    });
  }


  render() {
    console.log('App Rendered')

    return (
      <div>
        <Buttons handleSubmit={this.handleSubmit} />
        <Dashboard plants={this.state.plants} water={this.state.water} />
      </div>
    )
  }
  componentDidMount() {
    console.log("App mounted")
  }
};
