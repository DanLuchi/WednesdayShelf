WS.WeekController = Ember.Controller.extend
  week: (->
    return @get 'model'
  ).property('model')
