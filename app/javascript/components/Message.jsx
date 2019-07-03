import React, { Component } from 'react';

class Message extends Component {
  componentDidUpdate() {
    // TODO: Switch this to React Animations: https://reactjs.org/docs/animation.html
    $('.message')
      .show()
      .delay(1500)
      .fadeOut();
  }

  render() {
    return (
      <div id="messageWrapper">
        <div className="message">{this.props.messageText}</div>
      </div>
    );
  }
}

export default Message;
