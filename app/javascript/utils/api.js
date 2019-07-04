import axios from 'axios';

axios.defaults.headers.common = {
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-TOKEN': document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content'),
};

export const waterAllPlants = () => {
  return axios
    .post('/water')
    .then(response => response.data)
    .catch(handleError);
};

export const waterOnePlant = plantId => {
  return axios
    .post('/water', {
      plant_id: plantId,
    })
    .then(response => response.data)
    .catch(handleError);
};

const handleError = error => {
  console.warn(error);
  return null;
};