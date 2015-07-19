class window.Game
  @gameGrid: {
    width: 33,
    height: 16,
    tile: {
      width: 32,
      height: 32
    }
    baseFloorHeight: 6
    playAreaWidth: 24
  }

  @gravityConst: 0.12

  @width: ->
    @gameGrid.width * @gameGrid.tile.width

  @height: ->
    @gameGrid.height * @gameGrid.tile.height

  @playAreaX: ->
    (@gameGrid.width - @gameGrid.playAreaWidth - 1) / 2

  @playAreaMaxX: ->
    @gameGrid.width - @playAreaX()

  # start our game
  @start: ->
    Crafty.init(@width(), @height())
    Crafty.background('rgb(249, 223, 125)')


    # Cover the floor in tiles
    for x in [0..@gameGrid.playAreaWidth]
      # These will be the platform 'tops'
      y = 0
      Crafty.e('Grass').at(x, y)
      for y in [(y + 1)..@gameGrid.height]
        # Under the platform 'tops' shall be the 'dirt' bits
        Crafty.e('Dirt').at(x, y)

    # Place the player
    Crafty.e("Player").at(1, 0)

window.addEventListener 'load', -> Game.start()
