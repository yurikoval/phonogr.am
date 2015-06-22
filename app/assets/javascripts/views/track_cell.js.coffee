Pg.TrackCellView = Ember.View.extend Ember.ViewTargetActionSupport,
  tagName: 'li'
  templateName: 'track_cell'
  attributeBindings: ['draggable']
  classNames: ['track']
  draggable: "true"

  dragStart: (ev) ->
    ev.dataTransfer.setData('text/data', @get('content.identifier'))

  doubleClick: ->
    @triggerAction
      action: 'changePlaylist'
      target: @get('controller.controllers.player')
      actionContext: @get('controller.model')
    @triggerAction
      action: 'playTrack'
      target: @get('controller.controllers.player')
      actionContext: @get('content')
