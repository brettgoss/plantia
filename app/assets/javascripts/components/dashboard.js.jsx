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
        {/* Water All and See All Buttons above cards */}
        <div id="button-all">
          <button className="button">Water All</button>
          <a className="button" href="/plants">See All</a>
        </div>

        <div className="wrapper">
        {
          this.state.plants.map((value, index) => {
            var waterinfo = []
            this.props.water.map((item, i) => {
              if (item.plant_id == value.id) {
                waterinfo.push(item)
              }
            })
            return <Card data={value} key={value.id} water={ waterinfo[waterinfo.length - 1] || '0' }/>
          })
        }
        </div>
      </div>
    )
  }
});
