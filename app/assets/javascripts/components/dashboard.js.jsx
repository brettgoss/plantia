var Dashboard = React.createClass({

  // Sets the state from the props being passed down from the dashboard controller.
  getInitialState: function() {
    return {
      plants: this.props.plants,
      water: this.props.water
    }
  },

  render: function() {
    console.log('Dashboard Loaded')
    return (
      <div>
        <div id="button-all">
          <button className="button">Water All</button>
          <a className="button" href="/plants">See All</a>
        </div>

        <Card data={this.state} />
        {/* Water All and See All Buttons below cards */}
      </div>
    )
  }
});
