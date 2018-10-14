const React = require('react');

class Message extends React.Component {

  componentDidUpdate() {
    $(".message").show().delay(1500).fadeOut();
  }

  render() {
    return (
      <div id='messageWrapper'>
        <div className='message'>{this.props.messageText}</div>
      </div>
    )
  }
}

module.exports = Message;