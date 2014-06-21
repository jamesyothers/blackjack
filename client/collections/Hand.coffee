class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
    @finalScore

  hit: ->
    if @getScore() < 21
      @add(@deck.pop()).last()
      if @getScore() > 21
        @trigger 'busted'


  stand: ->
    @getScore()
    @trigger 'stand'


  getScore: ->
    if @scores().length > 1
      if @scores()[1] > 21
        @finalScore = @scores()[0]
      else
        @finalScore = @scores()[1]
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
