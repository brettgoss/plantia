const React = require('react');

function getPlantHealth(timeToNextWater) {
  if (timeToNextWater >= 24) return plantHealth = 'good';
  if (timeToNextWater >= 1) return plantHealth = 'trouble';
  return plantHealth = 'bad';
}

class CardFooter extends React.Component {
  constructor (props) {
    super(props)
  }

  render() {
    let plantHealth = getPlantHealth(this.props.timeToNextWater)

    return (
      <React.Fragment>
        <input
          type="button"
          value={"Water"}
          className={"card-button card-button-" + plantHealth}
          onClick={this.props.handleSubmit} />
      </React.Fragment>
    )
  }
}

module.exports = CardFooter;