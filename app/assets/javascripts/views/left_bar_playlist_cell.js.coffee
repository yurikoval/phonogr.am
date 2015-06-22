Pg.LeftBarPlaylistCellView = Ember.View.extend
  templateName: 'left_bar_playlist_cell'
  classNames: ['left_bar_playlist_cell', 'list-group-item']
  tagName: 'li'
  classNameBindings: ['isSelected:active']
  isSelected: (->
    @get('context.id') is @get('controller.selectedPlaylist.id')
  ).property('controller.selectedPlaylist.id')

  dragOver: (ev) ->
    ev.preventDefault()

  drop: (ev) ->
    identifier = ev.dataTransfer.getData('text/data')
    playlist_tracks = @get('content.tracks')
    (@get('controller').store.filter 'track', (track) ->
      track.get('identifier') is identifier
    ).then (tracks) ->
      playlist_tracks.addObjects tracks
