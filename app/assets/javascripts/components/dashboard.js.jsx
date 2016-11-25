class Dashboard extends React.Component {

  // Sets the state from the props being passed down from the dashboard controller.
  constructor(props) {
    super(props)
    this.waterOne = this.props.waterOne
    this.state = {
      waterinfo: ''
    }
    // console.log('dashboard', this.state.water)
  }

  render() {
    console.log('Dashboard Rendered')

    return (
        <div className="wrapper">
          {
            this.props.plants.map((value, index) => {
              console.log('Mapping Plants')
              this.props.water.map((item, i) => {
                if (item.plant_id == value.id) {
                  console.log('Mapping Water Events')
                  this.state.waterinfo = item
                }
              })
              return (
              <Card
                waterOne={this.waterOne}
                key={value.id}
                data={value}
                water={ this.state.waterinfo } />
              )
            })
          }

      </div>
    )
  }
  componentDidMount() {
    console.log("Dashboard mounted")
  }
};
