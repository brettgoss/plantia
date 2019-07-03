import React, { Component } from 'react';

class ButtonBar extends Component {
  render() {
    return (
        <div id="buttonBar">
          <a className="button" href="/plants">See All</a>
          <button className="button" onClick={this.props.waterPlants}>Water All</button>
          <a className="button" href="/plants/new">+ New Plant</a>
        </div>
    )
  }
};

export default ButtonBar;