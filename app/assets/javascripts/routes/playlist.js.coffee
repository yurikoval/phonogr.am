Pg.PlaylistRoute = Ember.Route.extend
  serialize: (model, params) ->
    { playlist_id: model.get('slug') }
  model: (params) ->
    @store.filter 'playlist', (playlist) ->
      playlist.get('slug') is params.playlist_id
