#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get("playerHand").on "stand", =>
      console.log(@get('dealerHand'))
      @get('dealerHand').models[0].flip()
      @dealForDealer();

  dealForDealer: ->
    console.log @get('dealerHand').getScore()
