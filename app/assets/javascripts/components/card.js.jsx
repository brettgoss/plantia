var Card = React.createClass({

  render: function() {
    console.log(this.props.data)
    return (
      <div>
        {
          this.props.data.map(function(value, index){
            return (
              <div key={index} className="card">
                <p>{value.nickname}</p>
                <p>{value.common_name}</p>
              </div>

            )
          })
        }
      </div>

    )
  }
});
