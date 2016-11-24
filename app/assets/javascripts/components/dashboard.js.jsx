var Dashboard = React.createClass({

  // Sets the state from the props being passed down from the dashboard controller.
  getInitialState: function() {
    return {
      plants: this.props.plants,
      water: this.props.water
    }
  },

  handleSubmit: function() {
    $.ajax({
      url: '/waterall',
      type: "POST"
    }).then(function(){
      $(".message0").text("All your plants have been watered!");
      $(".message0").show().delay(1000).fadeOut();
    });
  },

  render: function() {
    console.log('Dashboard Loaded')
    return (
      <div>
        {/* Water All and See All Buttons above cards */}
        <div id="button-all">
          <div className="message0"></div>
          <button className="button" onClick={this.handleSubmit}>Water All</button>
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
