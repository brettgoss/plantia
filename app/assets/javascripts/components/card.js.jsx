class Card extends React.Component {

  // Receives the props being passed down from the Dashboard component.
  constructor(props) {
    super(props)

    this.waterOne = this.props.waterOne
    this.daysTillWater = this.daysTillWater.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  // Triggered by the water button onClick, then passes data to the App component
  handleSubmit(event){
    let plantId = event.target.id
    this.props.waterOne(plantId)
  }

  // Calculation for how many days until the plant needs to be watered
  // based on the provided water frequency and the most recent waterEvent
  daysTillWater(waterEvent, waterFreq) {
    let num = waterEvent;
    let now = moment();
    let hours = moment.duration(now.diff(num)).asHours();
    let freq = moment.duration(waterFreq, 'days').asHours();
    let diff = moment(freq) - hours;
    return Math.floor(diff);
  }

  render() {
    console.log('Card Rendered')

    // Build a formatted water event wrapped in a div.
    let waterEvent;
    if (this.props.data.id == this.props.water.plant_id) {
      waterEvent = (
        <div className="plant-details">
          <div>{moment(this.props.water.water_date).format('h:mma - MMM D, Y')}</div>
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
            <div className="plant-details">Water in {this.daysTillWater(this.props.water.water_date, this.props.data.water_freq)} hours</div>
          </div>
        </a>
        {/* Plant Water Button */}
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
    console.log('Card Mounted')
  }
}
