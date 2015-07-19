Crafty.c "Player", {
  width: 32
  height: 48
  init: ->
    @requires('spr_player, 2D, Canvas, Multiway, Collision, Gravity')
      .multiway(4,
        # Key bindings, and direction to move (in degrees)
        D: 0
        A: 180,
        RIGHT_ARROW: 0,
        LEFT_ARROW: 180
      )
      .attr {
        w: @width,
        h: @height
      }
      .registerCollisions()
      .gravity("Floor")
      .gravityConst(Game.gravityConst)

  at: (x, y) ->
    transX = Game.playAreaX()
    transY = (Game.gameGrid.height - Game.gameGrid.baseFloorHeight + 1)
    x = x * Game.gameGrid.tile.width + transX * Game.gameGrid.tile.width
    y = y * Game.gameGrid.tile.height + transY * Game.gameGrid.tile.height - @height
    @attr {x, y}
    this

  registerCollisions: ->
    # Stop on solid objects
    @onHit('Solid', @stopMovement)
    @onHit('LevelEnd', @completeLevel)

  stopMovement: ->
    @_speed = 0
    if @_movement
      @x -= @_movement.x
      @y -= @_movement.y

  completeLevel: (data) ->
    endMarker = data[0].obj
    endMarker.collect()
}
