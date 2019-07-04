import React from 'react';

function getPlantHealth(timeToNextWater) {
  return timeToNextWater >= 24
    ? 'good'
    : timeToNextWater >= 1
    ? 'trouble'
    : 'bad';
}

function getInputText(plantId) {
  return plantId ? 'Water' : 'Create New Plant';
}

function CardFooter({ id, timeToNextWater, handleSubmit }) {
  const plantHealth = getPlantHealth(timeToNextWater);
  const inputText = getInputText(id);

  return (
    <input
      type="button"
      value={inputText}
      className={'card-button card-button-' + plantHealth}
      onClick={handleSubmit}
    />
  );
}

export default CardFooter;
