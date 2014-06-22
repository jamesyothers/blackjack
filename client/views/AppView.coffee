class window.AppView extends Backbone.View
  # template for the app includes three buttons, two sets of Hand cards, and a 'winner' alert banner
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="reset-button">Reset</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="winner"><%= winner %></div>
  '

  events:
    # the hit and stand methods are called on the Hand instances created by the Deck
    # playerHand is a property of the app model
    "click .hit-button": ->
      @model.get('playerHand').hit()
    "click .stand-button": ->
      # $('.stand-button').prop("disabled", true)
      @model.get('playerHand').stand()
    "click .reset-button": ->
      # @model.get('playerHand').getScore().set('');
      # reset to a new game by initializing the app model
      @model.initialize()
      # re-render on reset
      @render()



  initialize: ->
    # re-render on 'winner' being determined
    @model.on 'winner', (winner) =>
      @render()
    @render()


  render: ->
    @$el.children().detach()
    # the template uses the app model attributes property
    # all proerties set in the app model's initialize function are in the attributes property object
    @$el.html @template(@model.attributes)
    # create a new HandView insance for each the player and dealer's cards
    # these are based on the collections of player and dealer Hands in the app model
    # these classes are in the above template
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
