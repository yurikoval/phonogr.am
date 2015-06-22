Pg.Playlist = DS.Model.extend
  type: DS.attr('string')
  title: DS.attr('string')
  tracks: DS.hasMany('track')
  loadedCount: Ember.computed 'tracks.@each', ->
    @get('tracks.content').length
  slug: Ember.computed 'title', ->
    return 'search' if @get('type') is 'search'
    @get('title').toLowerCase().replace(/[^a-z]/g, '-').replace(/-{2,}/g, '-')
  totalCount: DS.attr 'integer',
    default: 0
  paginateable: Ember.computed 'loadedCount', 'totalCount', ->
    @get('loadedCount') < @get('totalCount')
