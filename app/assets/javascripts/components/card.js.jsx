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
                <content>
                  <h5>{value.light}</h5>
                  <h5>Water every {value.water_freq} days</h5>
                </content>
              </div>
            )
          })
        }
      </div>

    )
  }
});
