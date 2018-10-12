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
          <div className="message0"></div>
          <a className="button" href="/plants">See All</a>
          <button className="button" onClick={this.props.handleSubmit}>Water All</button>
          <a className="button" href="/plants/new">+ New Plant</a>
        </div>
    )
  }

  componentDidMount() {
    console.log("Buttons Mounted")
  }
};

module.exports = Buttons;