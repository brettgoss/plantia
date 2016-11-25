class Card extends React.Component {
  // Sets the state with the props being passed down from the dashboard. Not currently in use.
  constructor(props) {
    super(props)
    this.waterOne = this.props.waterOne
    this.handleSubmit = this.handleSubmit.bind(this)
    // console.log('card', this.props)

  }
  handleSubmit(event){
    let plantId = event.target.id
    this.props.waterOne(plantId)
    // alert(plantId)
  }

  render() {
    console.log('Card rendered', this.props)
    var event;

    if (this.props.data.id == this.props.water.plant_id) {
      event = (
        <div className="plant-details">
          <div>{ moment(this.props.water.water_date).format('h:mma - MMM D, Y').toString() }</div>
        </div>
      )
    }
    return (
        <div key={this.props.data.index} className="card">
        {/* Plant card header */}
        <a href={"/plants/" + this.props.data.id}>
          <header className="plant-header">
            <img className="plant-image" src="/favicon.ico"/>
            <div className="plant-head">
              <div className="plant-nickname">{this.props.data.nickname}</div>
              <div className="plant-common">{this.props.data.common_name}</div>
            </div>
          </header>
          {/* Plant card body */}
          <div className="plant-content">
            <div className="plant-details">{this.props.data.light}</div>
            {event}
            <div className="plant-details">Water every {this.props.data.water_freq} days</div>
          </div>
        </a>
        <input
          type="button"
          id={this.props.data.id}
          value={"Water"}
          onClick={this.handleSubmit} />
          {/*<%= button_to 'Water', water_events_path, method: 'post', remote: true, params: { plant_id: plant.id } %>*/}
      </div>
    )
  }
  componentDidMount() {
    console.log("Card mounted")
  }
}
