class Card extends React.Component {

  // Receives the props being passed down from the Dashboard component.
  constructor(props) {
    super(props)

    this.waterOne = this.props.waterOne
    this.lastWatered = this.lastWatered.bind(this)
    this.waterNext = this.waterNext.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  // Triggered by the water button onClick, then passes data to the App component
  handleSubmit(event){
    let plantId = event.target.id
    this.props.waterOne(plantId)
  }

  // Calculation for how many days until the plant needs to be watered
  // based on the provided water frequency and the most recent waterEvent
  lastWatered(waterEvent, waterFreq) {
    let num = moment(waterEvent);
    let freq = moment.duration(waterFreq, 'days').asHours();
    let result = moment(num).subtract(freq, 'hours').format('lll')
    return result;
  }

  waterNext(waterEvent) {
    let num = waterEvent;
    let now = moment();
    let hours = moment.duration(now.diff(num)).asHours();
    return Math.floor(0.1 - hours);
  }

  render() {
    console.log('Card Rendered')

    // Build a formatted water event wrapped in a div.
    let lastWaterEvent;
    if (this.props.data.id == this.props.water.plant_id) {
      lastWaterEvent = (
        <div className="plant-details">
          <div>{this.lastWatered(this.props.water.water_date, this.props.data.water_freq)}</div>
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
            <div className="card-info">Last Watered</div>
            {lastWaterEvent}
            <div className="plant-details">Needs watering every {this.props.data.water_freq} days</div>
            <div className="plant-details">Water in {this.waterNext(this.props.water.water_date)} hours</div>
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
