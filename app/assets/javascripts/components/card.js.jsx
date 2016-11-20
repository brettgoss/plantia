var Card = React.createClass({

  // Sets the state with the props being passed down from the dashboard. Not currently in use.
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
          // Map all of the plant info info individual cards.
          this.props.data.plants.map((value, index) => {
            return (
              <div key={index} className="card">
                {/* Plant card header */}
                <header className="plant-header">
                  <img className="plant-image" src="/favicon.ico"/>
                  <div className="plant-head">
                    <div className="plant-nickname">{value.nickname}</div>
                    <div className="plant-common">{value.common_name}</div>
                  </div>
                </header>

                {/* Plant card body */}
                <div className="plant-content">
                  <div className="plant-details">{value.light}</div>

                  <div className="plant-details">
                    {
                      // Maps the water info into each card
                      this.props.data.water.map((item, index) => {
                        // Only show the water info relavant to the card that it's inside
                        if (item.plant_id == value.id) {
                          return <div key={index}>{item.created_at}</div>
                        }
                      })
                    }
                  </div>

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
