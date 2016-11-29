class Dashboard extends React.Component {

  // Receives the props being passed down from the App component.
  constructor(props) {
    super(props)
    this.waterOne = this.props.waterOne
    this.state = {
      waterEvents: ''
    }
  }

  render() {
    console.log('Dashboard Rendered')
    let sortedArr = _.sortBy(this.props.plants, 'updated_at', function(n) {
      return n;
    })
    if (this.props.plants.length < 1){
      return (
        <div className="wrapper">
          <div className="card">
            <a href="/plants/">
              <header className="plant-header">
                <img className="plant-image" src="/favicon.ico"/>
                <div className="plant-head">
                  <div className="plant-nickname">Example</div>
                  <div className="plant-common">Placeholder Card</div>
                </div>
              </header>
              <div className="plant-content">
                <div className="plant-details">Add plants of your own to view their information!</div>
              </div>
            </a>
            <input
              type="button"
              value={"Water"}
              className="card-button" />
          </div>
        </div>
      )
    }
    else {
      return (
          <div className="wrapper">
            {
              sortedArr.map((value, index) => {
                this.props.water.map((item, i) => {
                  if (item.plant_id == value.id) {
                    this.state.waterEvents = item
                  }
                })

                return (
                <Card
                  key={value.id}
                  waterOne={this.waterOne}
                  data={value}
                  water={this.state.waterEvents} />
                )
              })
            }
        </div>
      )
    }
  }

  componentDidMount() {
    console.log("Dashboard Mounted")
  }
};
