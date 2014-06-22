class window.Card extends Backbone.Model
  # params is an object that includes a rank and suit property
  initialize: (params) =>
    @set
      # all cards are revealed except the dealer's first card before player 'stand'
      revealed: true
      # if params rank is zero or greater than than 10
      # covers king, jack, and queen
      value: if !params.rank or 10 < params.rank then 10 else params.rank
      # params.suit is a number from 0 to 3
      suitName: ['Spades', 'Diamonds', 'Clubs', 'Hearts'][params.suit]
      rankName: switch params.rank
        when 0 then 'King'
        when 1 then 'Ace'
        when 11 then 'Jack'
        when 12 then 'Queen'
        else params.rank
    # setting these properties in a separate section fixed the problem of having the cardFront and cardBack not being available in the Card view
    @set
      # build the file name of the card in the img/cards directory
      cardFront: @get('rankName') + '-' + @get('suitName') + '.png'
      # name of file in img directory
      cardBack: 'card-back.png'

  flip: ->
    # flip method of Card sets 'revealed' property to the opposite of what is currently there (Boolean)
    @set 'revealed', !@get 'revealed'
    @
