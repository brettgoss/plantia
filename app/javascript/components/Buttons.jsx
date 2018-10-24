const React = require('react');

class ButtonBar extends React.Component {
  constructor(props) {
    super(props)
  }

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

module.exports = ButtonBar;