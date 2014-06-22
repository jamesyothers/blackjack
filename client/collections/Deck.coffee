# a deck consists of 52 cards
class window.Deck extends Backbone.Collection
  # the deck consists of 52 instances of the Card model
  model: Card

  initialize: ->
    @add _(_.range(0, 52)).shuffle().map (card) ->
      # create a Card instance for each card
      # with properties of rank (0-12) and
      # suit (0-3)
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
  # each instance of Hand includes 2 Cards
  # the inputs for Hand are 'array' of two cards, Deck, and isDealer (true/false)
  # 'pop' is a Backbone method that removes a model from the end of the collection
  # this simulates dealing a card
  # .flip() changes what is rendered, the dealer's first card shows the back of the card
  dealPlayer: -> new Hand [ @pop(), @pop() ], @

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
