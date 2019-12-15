import React from 'react';

function CardHeader({ plant }) {
  return (
    <header className="plant-header">
      <img className="plant-image" src="/favicon.ico" />
      <div className="plant-head">
        <div className="plant-nickname">{plant.nickname}</div>
        <div className="plant-common">{plant.common_name}</div>
      </div>
    </header>
  );
}

export default CardHeader;
