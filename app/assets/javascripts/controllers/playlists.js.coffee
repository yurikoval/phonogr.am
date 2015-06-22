Pg.PlaylistsController = Ember.ArrayController.extend Ember.TargetActionSupport,
  needs: ['search']
  selectedPlaylist: null
  actions:
    selectPlaylist: (playlist) ->
      @set 'selectedPlaylist', playlist
      @transitionTo 'playlist', playlist
    selectSearchPlaylist: ->
      @set 'selectedPlaylist', null
      @transitionTo 'search'
    addNewPlaylist: ->
      name = prompt "Enter playlist name:"
      if name
        @store.createRecord 'playlist',
          type:   'playlist'
          title:  name
