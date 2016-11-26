class Dashboard extends React.Component {

  constructor(props) {
    super(props)
    this.waterOne = this.props.waterOne
    this.state = {
      waterEvents: ''
    }
  }

  render() {
    console.log('Dashboard Rendered')
    var newArr = _.sortBy(this.props.plants, 'updated_at', function(n) {
      return n;
    });
    return (
        <div className="wrapper">
          {
            newArr.map((value, index) => {
              console.log('Mapping Plants')

              this.props.water.map((item, i) => {
                if (item.plant_id == value.id) {
                  // console.log('Mapping Water Events')
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
    console.log("Dashboard mounted")
  }
};
