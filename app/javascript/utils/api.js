const axios = require('axios');

axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
};

function postWaterAll () {
  return axios.post('/water')
    .then(function (response) {
      return response.data;
    })
}

function postWaterOne (plantId) {
    return axios.post('/water', {
      plant_id: plantId,
    })
    .then(function (response) {
      return response.data;
    })
}

function handleError (error) {
  console.warn(error);
  return null;
}

module.exports = {

  waterAllPlants: function() {
    return postWaterAll()
      .catch(handleError);
  },
  waterOnePlant: function (plantId) {
    return postWaterOne(plantId)
      .catch(handleError);
  }
}
