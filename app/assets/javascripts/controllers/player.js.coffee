Pg.PlayerController = Ember.ObjectController.extend
  player: null
  status: undefined
  currentPlaylist: null
  loadedFraction: 0
  currentTime: 0
  total_time: 0
  current_time_in_thousand: Ember.computed 'currentTime', ->
    return 0 if @get('total_time') <= 0
    @get('currentTime') * 1000 / @get('total_time')
  current_time_formatted: Ember.computed 'currentTime', ->
    now = @get 'currentTime'
    s = Math.round(now % 60) # format seconds
    s = "0" + s if s < 10
    m = Math.floor(now / 60) # format minutes
    "#{m}:#{s}"
  time_left_formatted: Ember.computed 'currentTime', ->
    now = @get 'currentTime'
    total = @get 'total_time'
    left = total - now
    s = Math.round(left % 60) # format seconds
    s = "0" + s  if s < 10
    m = Math.floor(left / 60) # format minutes
    "-#{m}:#{s}"
  onPlayerReady: (event) ->
    console.log "Triggered onPlayerReady on #yt_player"
    @updateStats()
    return
  onPlayerStateChange: (event) ->
    switch event.data
      when YT.PlayerState.UNSTARTED then console.log "Player state changed to unstarted."
      when YT.PlayerState.ENDED then @playNext()
      when YT.PlayerState.PLAYING then console.log "Player state changed to playing."
      when YT.PlayerState.PAUSED then console.log "Player state changed to paused."
      when YT.PlayerState.BUFFERING then console.log "Player state changed to buffering."
      when YT.PlayerState.CUED then console.log "Player state changed to cued."
      else
        throw "Unrecognized youtube code: #{event.data}"
  onPlaybackQualityChange: (event) ->
    console.log "Triggered onPlaybackQualityChange on #yt_player"
  onError: (event) ->
    console.log "Triggered onError on #yt_player"
  updateStats: ->
    Ember.run.later this, ->
      if @get('player')
        @set 'currentTime', @get('player').getCurrentTime()
        @set 'total_time', @get('player').getDuration()
        @set 'loadedFraction', @get('player').getVideoLoadedFraction()
      @updateStats()
    , 500
  actions:
    playTrack: (track) ->
      console.log "Will be playing #{track.get('title')}"
      @storeTrackInHistory track
      @cueTrack track
      @startPlay()
    togglePlayPause: ->
      if @get('isPlaying')
        @stopPlay()
      else
        @startPlay()
    changePlaylist: (playlist) ->
      console.log "Changin playlist to #{playlist.get('title')}"
      @set 'currentPlaylist', playlist
    playNext: ->
      console.log "Playing next..."
      @playNext()
    playPrevious: ->
      console.log "Playing previous..."
      if @get('currentPlaylist')?
        current_track = @get('model')
        current_track_index = @get('currentPlaylist.tracks').indexOf(current_track)
        next_track = @get('currentPlaylist.tracks').objectAt(current_track_index-1)
        if next_track?
          @send 'playTrack', next_track
    seekTo: (seek_to_index) ->
      @seekTo(seek_to_index)
  storeTrackInHistory: (track) ->
      @store.filter 'playlist', (playlist) ->
        playlist.get('type') is 'history'
      .then (history_array) ->
        history_array.get('firstObject.tracks').pushObject track
        track
  cueTrack: (track) ->
    @set 'model', track
    @get('player').cueVideoById track.get('identifier')
  startPlay: ->
    @get('player').playVideo()
    @set 'status', 'playing'
  stopPlay: ->
    @get('player').pauseVideo()
    @set 'status', 'paused'
  playNext: ->
    if @get('currentPlaylist')?
      current_track = @get('model')
      current_track_index = @get('currentPlaylist.tracks').indexOf(current_track)
      next_track = @get('currentPlaylist.tracks').objectAt(current_track_index+1)
      if next_track?
        @send 'playTrack', next_track
  seekTo: (seek_to_index) ->
    @get('player').seekTo @calculate_second(seek_to_index), true
  calculate_second: (seek_to_index) ->
    @get('player').getDuration() * parseInt(seek_to_index, 10) / 1000
  isPlaying: Ember.computed 'status', ->
    @get('status') == 'playing'
