Pg.SearchController = Pg.PlaylistController.extend
  queryTerm: ''
  actions:
    search: ->
      apiKey = window.youtube_key
      queryTerm = @get('queryTerm')
      @set 'model.title', "Search: #{queryTerm}"
      $.ajax "https://www.googleapis.com/youtube/v3/search?type=video&part=snippet&maxResults=50&q=#{queryTerm}&key=#{apiKey}"
      .then (response) =>
        model = @get('model')
        tracks = @get('model.tracks')
        tracks.toArray().forEach (track) ->
          tracks.removeObject track
        model.set 'totalCount', parseInt(response['pageInfo']['totalResults'], 10)
        for video in response.items
          track = @store.createRecord 'track',
            identifier: video['id']['videoId']
            title: video['snippet']['title']
            description: video['snippet']['description']
            thumbnailUrl: video['snippet']['thumbnails']['default']['url']
          model.get('tracks').pushObject track
        @transitionTo 'playlist', model
