# @cjsx React.DOM

'use strict'

React = require 'react'
ReactPropTypes = React.PropTypes
TodoActions = require '../../actions/TodoActions'
TodoTextInput = require './TodoTextInput.react'

cx = require 'react/lib/cx'

TodoItem = React.createClass(
  propTypes:
    todo: ReactPropTypes.object.isRequired

  getInitialState: ->
    isEditing: false

  _onToggleComplete: ->
    TodoActions.toggleComplete(@props.todo)

  _onDoubleClick: ->
    @setState(isEditing: true)

  # Event handler called within TodoTextInput.
  # Defining this here allows TodoTextInput to be used in multiple places
  # in different ways.
  # @param  {string} text
  _onSave: (text) ->
    TodoActions.updateText(@props.todo.id, text)
    @setState(isEditing: false)

  render: ->
    todo = @props.todo
    if @state.isEditing
      input =
        <TodoTextInput
          className='edit'
          onSave={@_onSave}
          value={todo.text}
        />

    # List items should get the class 'editing' when editing
    # and 'completed' when marked as completed.
    # Note that 'completed' is a classification while 'complete' is a state.
    # This differentiation between classification and state becomes important
    # in the naming of view actions toggleComplete() vs. destroyCompleted().
    return (
      <li
        className={cx(
          'completed': todo.complete
          'editing': @state.isEditing
        )}
        key={todo.id}>
        <div className='view'>
          <input
            className='toggle'
            type='checkbox'
            checked={todo.complete}
            onChange={@_onToggleComplete}
          />
          <label onDoubleClick={@_onDoubleClick}>
            {todo.text}
          </label>
          <button className='destory' onClick={@_onDestroyClick} />
        </div>
        {input}
      </li>
    )
)

module.exports = TodoItem
