# each Hand is a collection of 2 Cards
class window.Hand extends Backbone.Collection
  # each card in the Hand is a model Card instance
  model: Card
  # each card receives an array of 2 cards to simulate an initial deal,
  # a deck and an isDealer property (true/false)
  initialize: (array, @deck, @isDealer) ->
    @finalScore
  
  # any hand can receive a 'hit' or another card from the deck
  hit: ->
    # you can hit if your score is below 21
    if @getScore() < 21
      # 'add' is the Backbone method that adds a model to the collection
      # 'pop' is a backbone method that removes an item from the end of the collection (deck) and returns that value
      # 'last' is the jQuery mehod that returns the last element in the set
      #  add to the Hand collection the next card from the deck
      @add(@deck.pop()).last()
      # if over 21 trigger the 'busted' event, picked up in the app model
      if @getScore() > 21
        @trigger 'busted'

  # when the player stands, it triggers the 'stand' event, picked up in the app model
  stand: ->
    @getScore()
    @trigger 'stand'

  getScore: ->
    # if there is only one score in the scores array, this represents not having an ace
    if @scores().length > 1
      # if the value of the second element in the array is over 21, do not count the ace as an 11
      # and set the finalScore to the first element
      if @scores()[1] > 21
        @finalScore = @scores()[0]
      # otherwise, if the second card is not over 21, treat the ace as an 11
      else
        @finalScore = @scores()[1]
    # if the scores method returns one elment then the score will only be this one element
    else
      @finalScore = @scores()[0]

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]
