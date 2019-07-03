import React, { Component } from 'react';

class CardHeader extends Component {
  render() {
    return (
      <>
        <header className="plant-header">
          <img className="plant-image" src="/favicon.ico" />
          <div className="plant-head">
            <div className="plant-nickname">{this.props.plant.nickname}</div>
            <div className="plant-common">{this.props.plant.common_name}</div>
          </div>
        </header>
      </>
    )
  }
}

export default CardHeader;