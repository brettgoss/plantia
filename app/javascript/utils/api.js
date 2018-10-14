const axios = require('axios');

axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
};

module.exports = {

  postWaterAll: function() {
    return axios.post('/waterall')
      .then(function (response) {
        return response.data;
      }).catch(function (error) {
        console.log(error)
      })
  },

  postWaterOne: function (plantId) {
    return axios.post('/water_events', {
        plant_id: plantId,
      })
      .then(function (response) {
        return response.data;
      }).catch(function (error) {
        console.log(error)
      })
  }
}
