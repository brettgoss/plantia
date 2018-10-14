const React = require('react');
const Card  = require('./Card')

class Dashboard extends React.Component {

  // Receives the props being passed down from the App component.
  constructor(props) {
    super(props)

    this.waterOne = this.props.waterOne
    this.state = {
      waterEvent: ''
    }
  }

  render() {
    console.log('Dashboard Rendered')
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
              this.props.plants.map((plant, index) => {
                this.props.waterEvents.map((waterEvent, i) => {
                  if (waterEvent.plant_id == plant.id) {
                    //TODO: Why are setting the state inside render?
                    this.state.waterEvent = waterEvent
                  }
                })

                return (
                <Card
                  key={plant.id}
                  waterOne={this.waterOne}
                  data={plant}
                  waterEvent={this.state.waterEvent} />
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

module.exports = Dashboard;