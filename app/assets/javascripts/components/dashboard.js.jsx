class Dashboard extends React.Component {
  componentDidMount() {
    console.log("Dashboard mounted")
  }
  // Sets the state from the props being passed down from the dashboard controller.
  constructor(props) {
    super(props)
    this.onWaterEvent = this.onWaterEvent.bind(this)
    this.state = {
      plants: this.props.plants,
      water: this.props.water,
      waterinfo: ''
    }
    console.log('dashboard', this.state.water)
  }
  onWaterEvent(){
    console.log("Updated")
    alert("Updated")
    return ({
      waterinfo: 'Updated'
    })
  }


  render() {
    console.log('Dashboard Rendered')

    return (
        <div className="wrapper">
          {
            this.state.plants.map((value, index) => {
              console.log('Mapping Plants')
              this.state.water.map((item, i) => {
                console.log('Mapping Water Events')

                if (item.plant_id == value.id) {
                  this.state.waterinfo = item
                }
              })
              return <Card key={value.id} data={value} water={ this.state.waterinfo } />
            })
          }

      </div>
    )
  }
};
