class window.CardView extends Backbone.View

  className: 'card'

  template: _.template "<img src=img/cards/<%= cardFront.toLowerCase() %> height=100% width=100%>"

  # _.template '<%= rankName %> of <%= suitName %>'
  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
