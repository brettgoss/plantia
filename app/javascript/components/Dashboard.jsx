const React = require('react');
const Card  = require('./Card')

function getWaterEventByPlantId(waterEvents, plantId) {
  return waterEvents.filter((waterEvent) => {
    if (waterEvent.plant_id == plantId) {
      return waterEvent;
    }
  }).shift()
}

class Dashboard extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
        <div className="wrapper">
          {
            this.props.plants.map((plant, index) => {
              if (this.props.waterEvents) {
                waterEvent = getWaterEventByPlantId(this.props.waterEvents, plant.id)
              }

              return (
                <Card
                  key={plant.id}
                  plant={plant}
                  waterEvent={waterEvent}
                  waterPlant={this.props.waterPlant}
                />
              )
            })
          }
      </div>
    )
  }
};

module.exports = Dashboard;