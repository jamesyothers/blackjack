#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', undefined
    @get("playerHand").on "stand", =>
      if @get('playerHand').getScore() > 21
        @set 'winner', 'dealer'
        @trigger 'winner', @get 'winner'
      else
        @get('dealerHand').models[0].flip()
        @dealForDealer();


  dealForDealer: ->
    dealerHand = @get('dealerHand')
    dealerHand.hit() while @get('dealerHand').getScore() < 17
    dealerScore = @get('dealerHand').getScore()
    playerScore = @get('playerHand').getScore()

    if dealerScore > playerScore and dealerScore < 22
      @set 'winner', 'dealer'
    else if dealerScore < playerScore and playerScore < 22
      @set 'winner', 'player'
    else
      @set 'winner', 'push'

    @trigger 'winner', @get 'winner'

