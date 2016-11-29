class Dashboard extends React.Component {

  // Receives the props being passed down from the App component.
  constructor(props) {
    super(props)
    this.waterOne = this.props.waterOne
    this.state = {
      waterEvents: ''
    }
  }

  render() {
    console.log('Dashboard Rendered')
    let sortedArr = _.sortBy(this.props.plants, 'updated_at', function(n) {
      return n;
    })
    return (
        <div className="wrapper">
          {
            sortedArr.map((value, index) => {
              this.props.water.map((item, i) => {
                if (item.plant_id == value.id) {
                  this.state.waterEvents = item
                }
              })

              return (
              <Card
                key={value.id}
                waterOne={this.waterOne}
                data={value}
                water={this.state.waterEvents} />
              )
            })
          }

      </div>
    )
  }

  componentDidMount() {
    console.log("Dashboard Mounted")
  }
};
