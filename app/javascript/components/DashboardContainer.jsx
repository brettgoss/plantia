import { hot } from 'react-hot-loader/root';
import React, { useState } from 'react';

import api from '../utils/api';

import ButtonBar from './ButtonBar';
import Message from './Message';
import Dashboard from './Dashboard';

function waterPlants(plantId) {
  return plantId
    ? api.waterOnePlant(plantId).then(waterEvents => {
        return waterEvents;
      })
    : api.waterAllPlants().then(waterEvents => {
        return waterEvents;
      });
}

function DashboardContainer({ waterEvents: initialWaterEvents, plants }) {
  const [waterEvents, setWaterEvents] = useState(initialWaterEvents);
  const [messageText, setAlertMessage] = useState('');

  const handlePlantWatering = plantId => {
    const messageText = plantId
      ? 'Plant Watered!'
      : 'All your plants have been watered!';

    waterPlants(plantId).then(response => {
      setAlertMessage(messageText);
      setWaterEvents(response);
    });
  };

  return (
    <>
      <ButtonBar handlePlantWatering={handlePlantWatering} />
      <Message messageText={messageText} />
      <Dashboard
        plants={plants}
        waterEvents={waterEvents}
        waterPlant={handlePlantWatering}
      />
    </>
  );
}

export default hot(DashboardContainer);
