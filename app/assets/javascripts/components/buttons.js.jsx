class Buttons extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    console.log('Buttons Rendered')

    return (
        <div id="button-all">
          <div className="message0"></div>
          <button className="button" onClick={this.props.handleSubmit}>Water All</button>
          <a className="button" href="/plants">See All</a>
        </div>
    )
  }
  componentDidMount() {
    console.log("Buttons mounted")
  }
};
