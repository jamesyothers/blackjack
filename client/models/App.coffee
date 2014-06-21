#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', undefined

    @get("playerHand").on "stand", =>
      @get('dealerHand').models[0].flip()
      @dealForDealer();

    @get('playerHand').on 'busted', =>
      @set 'winner', 'dealer'
      @trigger 'winner', @get 'winner'

    @get('dealerHand').on 'busted', =>
      @set 'winner', 'player'
      @trigger 'winner', @get 'winner'


  dealForDealer: ->
    dealerHand = @get('dealerHand')
    dealerScore = @get('dealerHand').getScore()
    playerHand = @get('playerHand')
    playerScore = @get('playerHand').getScore()

    dealerHand.hit() while @get('dealerHand').getScore() < 17 or @get('playerHand').getScore() > @get('dealerHand').getScore()
    if dealerScore <= 21
      playerScore = @get('playerHand').getScore()

      if dealerScore > playerScore
        @set 'winner', 'dealer'
      else if dealerScore < playerScore
        @set 'winner', 'player'
      else
        if dealerScore == 21
          if dealerHand.length == 2 and playerHand.length == 2
            @set 'winner', 'push'
          else if dealerHand.length == 2
            @set 'winner', 'dealer'
          else if playerHand.length == 2
            @set 'winner', 'player'
          else
            @set 'winner', 'push'
        else
          @set 'winner', 'push'

      @trigger 'winner', @get 'winner'

