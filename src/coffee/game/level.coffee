class Game.Level
  constructor: (@major=0, @minor=0) ->

  sceneName: ->
    "Level#{Game.Utility.padString(@major, 2)}-#{Game.Utility.padString(@minor, 2)}"

  next: ->
    @minor += 1
    unless @start()
      @minor = 0
      @major += 1
      unless @start()
        Crafty.scene('Victory')

  start: ->
    return false unless Crafty._scenes[@sceneName()]?
    Crafty.scene(@sceneName(), this)
    true

  init: ->
    # Cover the floor in tiles
    for x in [0..Game.gameGrid.playAreaWidth]
      # These will be the platform 'tops'
      y = 0
      Crafty.e('Grass').at(x, y)
      for y in [(y + 1)..Game.gameGrid.height]
        # Under the platform 'tops' shall be the 'dirt' bits
        Crafty.e('Dirt').at(x, y)

  solidPlatform: (coords, topType='Grass', fillerType='Dirt') ->
    if coords.w % 1 == 0.5
      halfHor = 'right'
      coords.w -= 0.5
      skipX = 0.5
    else
      coords.w -= 1
      skipX = 1
    coords.h ||= coords.y * -1

    if coords.h % 1 == 0.5
      coords.h -= 0.5
      halfVert = 'top'
      skipY = 0.5
    else
      coords.h -= 1
      skipY = 1

    coords.y2 = coords.y + coords.h + skipY - 1
    coords.x2 = coords.x + coords.w + skipX - 1


    Crafty.e(topType).at(coords.x, coords.y)
      .half(halfHor, halfVert)

    firstLayer = true
    if coords.y2 > (coords.y + skipY)
      for y in [(coords.y + skipY)..coords.y2]
        Crafty.e(fillerType).at(coords.x, y)
          .half(halfHor, null)

        if coords.x2 > (coords.x + skipX)
          for x in [(coords.x + skipX)..coords.x2]

            if firstLayer
              Crafty.e(topType).at(x, y-skipY)
                .half(null, halfVert)

            Crafty.e(fillerType)
              .at(x, y)

      firstLayer = false
