Crafty.c "Player", {
  width: Game.gameGrid.tile.width * 0.75
  height: Game.gameGrid.tile.height * 1.5
  init: ->
    @requires('SolidHitBox, PlayerSprite, Collision, PlayerControls, GravityVelocity')
      .attr {
        w: @width,
        h: @height
      }
      # The hitbox of our little alien
      .collision([3, 42], [49, 42], [49, 105], [3, 105])
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

  stopMovement: (data) ->
    if @_velocity && !@ducking
      console.log "collision w/ solid"
      @x -= @_velocity.x

  completeLevel: (data) ->
    endMarker = data[0].obj
    endMarker.collect()
}
