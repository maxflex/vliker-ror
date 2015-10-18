  @myComponent = React.createClass
    notifyName: ->
      $.notify "Your name is #{this.props.name}"
    render: ->
      `<div>
        <h2>My name is {this.props.name}</h2>
        <a href='#' onClick={this.notifyName}>click</a>
       </div>`
