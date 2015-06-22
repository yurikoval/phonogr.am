Phonogram.ApplicationRoute = Ember.Route.extend
  setupController: ->
    @store.createRecord 'playlist',
      id:     'history'
      type:   'history'
      title:  'History'
    search_playlist = @store.createRecord 'playlist',
      type: 'search'
      title: "Search"
      id: 'search'
      queryTerm: ''

    @_super()
    @controllerFor('playlists').set 'model', @store.all('playlist')
    @controllerFor('search').set 'model', search_playlist
  renderTemplate: ->
    @render()
    @render 'player',
      outlet: 'player'
      into: 'application'
    @render 'left_bar',
      outlet: 'left_bar'
      into: 'application'
      controller: 'playlists'
    @render 'controls',
      outlet: 'controls'
      into: 'application'
      controller: @controllerFor('player')
    @render 'search',
      outlet: 'search'
      into: 'application'
      controller: @controllerFor('search')
