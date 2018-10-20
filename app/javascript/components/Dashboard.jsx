const React = require('react');
const Card  = require('./Card')

class Dashboard extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    return (
        <div className="wrapper">
          {
            this.props.plants.map((plant, index) => {
              return (
                <Card
                  key={plant.id}
                  plant={plant}
                  waterEvents={this.props.waterEvents}
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