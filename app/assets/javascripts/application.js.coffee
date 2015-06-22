#= require jquery
#= require jquery-ui
#= require twitter/bootstrap
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require phonogram

window.PgProperties =
  info: "Phonogram 0.1"

# for more details see: http://emberjs.com/guides/application/
window.Phonogram = window.Pg = Ember.Application.create
  LOG_TRANSITIONS: true
  LOG_TRANSITIONS_INTERNAL: true
  LOG_VIEW_LOOKUPS: true
  LOG_ACTIVE_GENERATION: true
  LOG_RESOLVER: true

Pg.deferReadiness()

window.onYouTubeIframeAPIReady = -> Pg.advanceReadiness()
