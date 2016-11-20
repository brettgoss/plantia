var Card = React.createClass({

  render: function() {
    console.log(this.props.data)
    return (
      <div className="wrapper">
        {
          this.props.data.map(function(value, index){
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
