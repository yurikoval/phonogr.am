Pg.PlayerView = Ember.View.extend
  classNames: ['player']
  didInsertElement: ->
    @set 'controller.player', new YT.Player 'yt_player',
      height: '100'
      width: '164'
      playerVars:
        controls: 0
        autoplay: 0
        fs: 1
        iv_load_policy: 3
        modestbranding: 1
        rel: 0
        showinfo: 0
        theme: 'light'
      events:
        onReady: (event) => @get('controller').onPlayerReady(event)
        onStateChange: (event) => @get('controller').onPlayerStateChange(event)
        onPlaybackQualityChange: (event) => @get('controller').onPlaybackQualityChange(event)
        onError: (event) => @get('controller').onError(event)
