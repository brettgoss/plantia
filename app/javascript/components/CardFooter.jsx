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
    let plantHealth = getPlantHealth(this.props.timeToNextWater);
    let inputText = this.props.id > 0 ? "Water" : "Create New Plant";

    return (
      <React.Fragment>
        <input
          type="button"
          value={inputText}
          className={"card-button card-button-" + plantHealth}
          onClick={this.props.handleSubmit}
        />
      </React.Fragment>
    )
  }
}

module.exports = CardFooter;