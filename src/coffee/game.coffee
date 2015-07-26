class window.Game
  @gameGrid: {
    width: 17,
    height: 8,
    tile: {
      width: 70,
      height: 70
    }
    baseFloorHeight: 3
    playAreaWidth: 12
  }

  @gravityConst: 0.2
  @terminalVelocity: 12

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

    Crafty.scene("Loading")

  @level: ->
    @_level ||= new @Level()

  @restart: ->
    @_level = null
    @level().next()

window.addEventListener 'load', -> Game.start()
