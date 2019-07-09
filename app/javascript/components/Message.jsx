import React, { useEffect } from 'react';

function Message({ messageText }) {
  useEffect(() => {
    // TODO: Switch this to React Animations: https://reactjs.org/docs/animation.html
    $('.message')
      .show()
      .delay(1500)
      .fadeOut();
  });

  return (
    <div id="messageWrapper">
      <div className="message">{messageText}</div>
    </div>
  );
}

export default Message;
