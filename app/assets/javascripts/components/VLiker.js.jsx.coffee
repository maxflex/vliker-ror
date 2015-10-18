  @VLiker = React.createClass
    render: ->
      `<div id="like-blocks">
         <div id="div-blocker"></div>
         <div class="block-line">
          <VLikerBlock task={this.props.tasks[0]} />
         </div>
         <div class="block-line">
         </div>
      </div>`
