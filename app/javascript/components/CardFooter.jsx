import React from "react";

function getPlantHealth(timeToNextWater) {
  if (timeToNextWater >= 24) return "good";
  if (timeToNextWater >= 1) return "trouble";
  return "bad";
}

function CardFooter({ id, timeToNextWater, handleSubmit }) {
  let plantHealth = getPlantHealth(timeToNextWater);
  let inputText = id > 0 ? "Water" : "Create New Plant";

  return (
    <>
      <input
        type="button"
        value={inputText}
        className={"card-button card-button-" + plantHealth}
        onClick={handleSubmit}
      />
    </>
  );
}

export default CardFooter;
