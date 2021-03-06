# @cjsx React.DOM

'use strict'

React = require 'react'
ReactPropTypes = React.PropTypes

MessageListItem  = React.createClass(
  propTypes:
    message: ReactPropTypes.object

  render: ->
    message = @props.message
    return (
      <li className='message-list-item'>
        <h5 className='message-author-name'>{message.authorName}</h5>
        <div className='message-time'>
          {message.date.toLocaleTimeString()}
        </div>
        <div className='message-text'>{message.text}</div>
      </li>
    )
)

module.exports = MessageListItem
