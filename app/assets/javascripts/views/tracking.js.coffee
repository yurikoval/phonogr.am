Pg.TrackingView = Ember.View.extend Ember.ViewTargetActionSupport,
  templateName: "tracking"
  elementSelector: ".tracking"
  slider_initialized: false
  slider: undefined
  progressbar_initialized: false
  progressbar: undefined
  didInsertElement: ->
    selector = @$(@get("elementSelector"))
    selector.progressbar
      value: 0
      max: 1000
      create: (event, ui) =>
        @set('progressbar', selector)
        @set('progressbar_initialized', true)
    .slider
      min: 0
      max: 1000
      orientatino: 'horizontal'
      step: 1
      slide: (e, ui) =>
        @triggerAction
          action: 'seekTo'
          target: @get('controller')
          actionContext: ui.value
      create: (event, ui) =>
        @set('slider', selector)
        @set('slider_initialized', true)
  playbackValueChanged: (->
    if @get('slider_initialized') and @get('slider')?
      @get('slider').slider('value', @get('controller.current_time_in_thousand'))
  ).observes('controller.current_time_in_thousand', 'slider_initialized', 'slider').on('init')
  loadedValueChanged: (->
    if @get('progressbar_initialized') and @get('progressbar')?
      @get('progressbar').progressbar('value', @get('controller.loadedFraction') * 1000)
  ).observes('controller.loadedFraction', 'progressbar_initialized', 'progressbar').on('init')
