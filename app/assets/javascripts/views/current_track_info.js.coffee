Pg.currentTrackInfoView = Ember.View.extend
  tagName: 'span'
  classNames: ['current_track_info']
  templateName: 'current_track_info'
  track: Ember.computed.alias 'controller.model'
  track_text: Ember.computed 'controller.model.title', ->
    if @get('track')?
      @get('track.title')
    else
      PgProperties.info
