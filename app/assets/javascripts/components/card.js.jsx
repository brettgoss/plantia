var Card = React.createClass({

  // Sets the state with the props being passed down from the dashboard. Not currently in use.
  getInitialState: function() {
    return {
      value: this.props.data,
      index: this.props.index,
      water: this.props.water
    }
  },

  render: function() {
    console.log('log' + this.state.value.id, this.state.water)

    var event;
    if (this.state.value.id == this.state.water.plant_id) {
      event = (
        <div className="plant-details">
          <div>{ moment(this.state.water.water_date).format('h:mma - MMM D, Y').toString() }</div>
        </div>
      )
    }

    return (
      <a href={"/plants/" + this.state.value.id}>
        <div key={this.state.index} className="card">
        {/* Plant card header */}
          <header className="plant-header">
            <img className="plant-image" src="/favicon.ico"/>
            <div className="plant-head">
              <div className="plant-nickname">{this.state.value.nickname}</div>
              <div className="plant-common">{this.state.value.common_name}</div>
            </div>
          </header>
          {/* Plant card body */}
          <div className="plant-content">
            <div className="plant-details">{this.state.value.light}</div>
            {event}
            <div className="plant-details">Water every {this.state.value.water_freq} days</div>
          </div>
      </div>
    </a>
    )
  }
})
