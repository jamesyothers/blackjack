# todo: refactor to have a game beneath the outer blackjack model
# this is the clearning house for the entire app
# the app model will handle all model to model communications 
# it is best to delegate as much logic as possible to lower models
class window.App extends Backbone.Model
  
  initialize: ->
    # create a new deck on initialization
    @set 'deck', deck = new Deck()
    # 'dealPlayer()' will create a new Hand instance for each the player and dealer
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # the 'winner' property will be set to the displayed message at the end of a game
    @set 'winner', undefined

    # the event listener for 'stand' will listen for this even from the 'playerHand' 
    # 'playerHand' is an instance of Hand
    @get("playerHand").on "stand", =>
      # upon the player 'stand' the dealer's first card will be shown
      @get('dealerHand').models[0].flip()
      # then deal the dealer's cards
      @dealForDealer();

    # listen from the playerHand Hand instance for the 'busted' event
    # then set 'winner' to dealer
    # then trigger the 'winner' even to be picked up by the app view to be re-rendered
    @get('playerHand').on 'busted', =>
      @set 'winner', 'Dealer Wins!'
      @trigger 'winner', @get 'winner'

    # similar logic for dealer
    @get('dealerHand').on 'busted', =>
      @set 'winner', 'You Win!'
      @trigger 'winner', @get 'winner'

  # after the player stands, deal the dealer's extra cards as necessary
  dealForDealer: ->
    playerHand = @get('playerHand')
    playerScore = @get('playerHand').getScore()
    # while the dealer's score is less than 17 or less than the player's socre, continue to hit
    @get('dealerHand').hit() while @get('dealerHand').getScore() < 17 or playerScore > @get('dealerHand').getScore()
    dealerScore = @get('dealerHand').getScore()
    dealerHand = @get('dealerHand');
    # score logic to determine winner
    if dealerScore <= 21
      if dealerScore > playerScore
        @set 'winner', 'Dealer Wins!'
      else if dealerScore < playerScore
        @set 'winner', 'You Win!'
      else
        # test for blackjack circumstances in player and deck
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

