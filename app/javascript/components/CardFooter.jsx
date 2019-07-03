import React, { Component } from 'react';

function getPlantHealth(timeToNextWater) {
  if (timeToNextWater >= 24) return 'good';
  if (timeToNextWater >= 1) return 'trouble';
  return 'bad';
}

class CardFooter extends Component {
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

export default CardFooter;