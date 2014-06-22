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
      @set 'winner', 'Dealer Wins!'
      @trigger 'winner', @get 'winner'

    @get('dealerHand').on 'busted', =>
      @set 'winner', 'You Win!'
      @trigger 'winner', @get 'winner'


  dealForDealer: ->
    playerHand = @get('playerHand')
    playerScore = @get('playerHand').getScore()
    @get('dealerHand').hit() while @get('dealerHand').getScore() < 17 or playerScore > @get('dealerHand').getScore()
    dealerScore = @get('dealerHand').getScore()
    dealerHand = @get('dealerHand');
    if dealerScore <= 21
      if dealerScore > playerScore
        @set 'winner', 'Dealer Wins!'
      else if dealerScore < playerScore
        @set 'winner', 'You Win!'
      else
        if dealerScore == 21
          if dealerHand.length == 2 and playerHand.length == 2
            @set 'winner', "It's A Push!"
          else if dealerHand.length == 2
            @set 'winner', 'Dealer Wins'
          else if playerHand.length == 2
            @set 'winner', 'You Win!'
          else
            @set 'winner', "It's A Push!"
        else
          @set 'winner', "It's A Push!"

      @trigger 'winner', @get 'winner'

