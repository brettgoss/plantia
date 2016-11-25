class App extends React.Component {
  componentDidMount() {
    console.log("App mounted")
  }
  // Sets the state from the props being passed down from the dashboard controller.
  constructor(props) {
    super(props)
    this.state = {
      plants: this.props.plants,
      water: this.props.water,
    }
    // console.log(this.state)
  }


  handleSubmit() {
    $.ajax({
      url: '/waterall',
      type: "POST"
    }).then(function(){
      $(".message0").text("All your plants have been watered!");
      $(".message0").show().delay(1000).fadeOut();
    });
    this.setState({water: this.water})
  }


  render() {
    console.log('App Rendered')

    return (
      <div>
        <div id="button-all">
          <div className="message0"></div>
          <button className="button" onClick={this.handleSubmit}>Water All</button>
          <a className="button" href="/plants">See All</a>
        </div>

        <Dashboard plants={this.state.plants} water={this.state.water} />
      </div>
    )
  }
};
