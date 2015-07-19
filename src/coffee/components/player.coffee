Crafty.c "Player", {
  width: 32
  height: 48
  init: ->
    @requires('2D, Canvas, Multiway, Color, Collision, Gravity')
      .multiway(4,
        # Key bindings, and direction to move (in degrees)
        D: 0
        A: 180,
        RIGHT_ARROW: 0,
        LEFT_ARROW: 180
      )
      .color('rgb(20, 75, 40)')
      .attr {
        w: @width,
        h: @height
      }
      .stopOnSolids()
      .gravity("Floor")
      .gravityConst(Game.gravityConst)

  at: (x, y) ->
    transX = Game.playAreaX()
    transY = (Game.gameGrid.height - Game.gameGrid.baseFloorHeight)
    x = x * Game.gameGrid.tile.width + transX * Game.gameGrid.tile.width
    y = y * Game.gameGrid.tile.height + transY * Game.gameGrid.tile.height - @height
    @attr {x, y}
    this

  stopOnSolids: ->
    @onHit('Solid', @stopMovement)
    this

  stopMovement: ->
    @_speed = 0
    if @_movement
      @x -= @_movement.x
      @y -= @_movement.y
}
