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
