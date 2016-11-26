class Card extends React.Component {

  // Sets the state with the props being passed down from the dashboard. Not currently in use.
  constructor(props) {
    super(props)
    this.waterOne = this.props.waterOne
    this.daysTillWater = this.daysTillWater.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }
  handleSubmit(event){
    let plantId = event.target.id
    this.props.waterOne(plantId)
  }
  daysTillWater(waterEvent, waterFreq) {

    let num = waterEvent;
    let now = moment();

    let hours = moment.duration(now.diff(num)).asHours();
    let freq = moment.duration(waterFreq, 'days').asHours();
    let diff = moment(freq) - hours;

    return Math.floor(diff);
  }

  render() {
    console.log('Card rendered')
    var waterEvent;

    if (this.props.data.id == this.props.water.plant_id) {
      var rawEvent = this.props.water.water_date
      waterEvent = (
        <div className="plant-details">
          <div>{moment(rawEvent).format('h:mma - MMM D, Y')}</div>
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
            <div className="card-info">Light Requirements:</div>
            <div className="plant-details">{this.props.data.light}</div>
            <div className="card-info">Last Watered:</div>
            {waterEvent}
            <div className="plant-details">Needs watering every {this.props.data.water_freq} days</div>
            <div className="plant-details">Water in {this.daysTillWater(rawEvent, this.props.data.water_freq)} hours</div>
          </div>
          {/* Plant Water Button */}
        </a>
        <input
          id={this.props.data.id}
          type="button"
          value={"Water"}
          className="card-button"
          onClick={this.handleSubmit} />
      </div>
    )
  }
  componentDidMount() {
    console.log("Card mounted")
  }
}
