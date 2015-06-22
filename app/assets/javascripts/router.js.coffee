# For more information see: http://emberjs.com/guides/routing/

Phonogram.Router.map ()->
  @resource 'playlists', ->
    @resource 'playlist', {path: '/:playlist_id'}

