var Dashboard = React.createClass({
  getInitialState: function() {
    return {
      plants: this.props.data
    }
  },

  render: function() {
    console.log('Dashboard Loaded')
    return (
      <Card data={this.state.plants} />
    )
  }
});
