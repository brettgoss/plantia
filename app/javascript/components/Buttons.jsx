const React = require('react');

class Buttons extends React.Component {

  // Receives the props being passed down from the App component.
  constructor(props) {
    super(props)
  }

  render() {
    console.log('Buttons Rendered')

    return (
        <div id="button-all">
          <a className="button" href="/plants">See All</a>
          <button className="button" onClick={this.props.waterPlants}>Water All</button>
          <a className="button" href="/plants/new">+ New Plant</a>
        </div>
    )
  }

  componentDidMount() {
    console.log("Buttons Mounted")
  }
};

module.exports = Buttons;