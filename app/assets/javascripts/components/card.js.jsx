var Card = React.createClass({
  getInitialState: function() {
    return {
      plants: this.props.data.plants,
      water: this.props.data.water
    }
  },

  render: function() {
    console.log(this.state.water)
    return (
      <div className="wrapper">
        {
          this.props.data.plants.map((value, index) => {
            return (
              <div key={index} className="card">
                <header className="plant-header">
                  <img className="plant-image" src="/favicon.ico"/>
                  <div className="plant-head">
                    <div className="plant-nickname">{value.nickname}</div>
                    <div className="plant-common">{value.common_name}</div>
                  </div>
                </header>
                <div className="plant-content">
                  <div className="plant-details">{value.light}</div>
                  <div className="plant-details">{this.props.data.water.map((item, index) => {
                      if (item.plant_id == value.id) {
                        return <div key={index}>{item.created_at}</div>
                      }
                    })}</div>
                  <div className="plant-details">Water every {value.water_freq} days</div>
                </div>
              </div>
            )
          })
        }
      </div>

    )
  }
});
