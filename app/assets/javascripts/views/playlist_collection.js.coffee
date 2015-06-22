Pg.PlaylistCollectionView = Ember.CollectionView.extend
  tagName: 'ul'
  contentBinding: 'controller.tracks'
  itemViewClass: 'Pg.TrackCellView'
