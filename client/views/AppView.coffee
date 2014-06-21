class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="reset-button">Reset</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="winner"><%= winner %></div>
  '

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()
    "click .stand-button": ->
      # $('.stand-button').prop("disabled", true)
      @model.get('playerHand').stand()
    "click .reset-button": ->
      # @model.get('playerHand').getScore().set('');
      @model.initialize()
      @render()



  initialize: ->
    @model.on 'winner', (winner) =>
      @render()
    @render()


  render: ->
    @$el.children().detach()
    @$el.html @template(@model.attributes)
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
