import React from 'react';

function ButtonBar({ handlePlantWatering }) {
  const handleSubmit = () => handlePlantWatering();

  return (
    <div id="buttonBar">
      <a className="button" href="/plants">
        See All
      </a>
      <button className="button" onClick={handleSubmit}>
        Water All
      </button>
      <a className="button" href="/plants/new">
        + New Plant
      </a>
    </div>
  );
}

export default ButtonBar;
