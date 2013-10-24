WS.Issue = DS.Model.extend
  release: DS.belongsTo 'WS.Release'
  raw_title: DS.attr 'string'
  stock_number: DS.attr 'string'
  diamond_number: DS.attr 'string'
  description: DS.attr 'string'
  release_date: DS.attr 'string'
  price: DS.attr 'number'
  title: DS.attr 'string'
  special_issue_number: DS.attr 'string'
  issue_number: DS.attr 'string'
  max_issue: DS.attr 'string'
  author: DS.attr 'string'
  artist: DS.attr 'string'
  cover_artist: DS.attr 'string'
  series_title: DS.attr 'string'
  grid_cover_url: DS.attr 'string'
  cover_url: DS.attr 'string'
  release_id: DS.attr 'number'

  release: (->
    WS.Release.find(@get('release_id'))
  ).property('release_id')

