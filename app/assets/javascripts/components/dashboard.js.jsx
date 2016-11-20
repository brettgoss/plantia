var Dashboard = React.createClass({
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
