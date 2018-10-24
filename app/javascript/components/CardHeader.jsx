const React = require('react');

class CardHeader extends React.Component {
  constructor (props) {
    super(props)
  }

  render() {
    return (
      <React.Fragment>
        <header className="plant-header">
          <img className="plant-image" src="/favicon.ico" />
          <div className="plant-head">
            <div className="plant-nickname">{this.props.plant.nickname}</div>
            <div className="plant-common">{this.props.plant.common_name}</div>
          </div>
        </header>
      </React.Fragment>
    )
  }
}

module.exports = CardHeader;