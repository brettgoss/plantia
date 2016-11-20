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
      <Card data={this.state} />
    )
  }
});
