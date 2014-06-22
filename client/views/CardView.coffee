class window.CardView extends Backbone.View
  # the classname for each card tag is 'card'
  className: 'card'
  # each card has a default of the 'cardFront' property which is the name of the card in the img/cards folder
  # height and width to 100% will fill the container fully
  template: _.template "<img src=img/cards/<%= cardFront.toLowerCase() %> height=100% width=100%>"
  
  # if the card changes, re-render
  initialize: ->
    @model.on 'change', => @render
    # render on intialization
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
