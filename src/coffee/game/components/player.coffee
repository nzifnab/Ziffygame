Crafty.c "Player", {
  width: Game.gameGrid.tile.width * 0.75
  height: Game.gameGrid.tile.height * 1.5
  init: ->
    @hitbox = Crafty.e("PlayerHitBox")
    @requires('PlayerSprite, GravityVelocity, PlayerControls')
      .attr {
        w: @width,
        h: @height
      }
      # The hitbox of our little alien
      #.collision([3, 42], [49, 42], [49, 105], [3, 105])
      .attach(@hitbox)
      #.registerCollisions()
      .gravity("Floor")
      .gravityConst(Game.gravityConst)
      .terminalVelocity(Game.terminalVelocity)
      .bindMovementControls()
      #.color('blue')

  setHitbox: (x, y, w, h)->
    x ||= @hitbox.baseX
    y ||= @hitbox.baseY
    w ||= @hitbox.baseW
    h ||= @hitbox.baseH
    @hitbox.x = x + @_x
    @hitbox.y = y + @_y
    @hitbox.w = w
    @hitbox.h = h

  at: (x, y) ->
    transX = Game.playAreaX()
    transY = (Game.gameGrid.height - Game.gameGrid.baseFloorHeight + 1)
    x = x * Game.gameGrid.tile.width + transX * Game.gameGrid.tile.width
    y = y * Game.gameGrid.tile.height + transY * Game.gameGrid.tile.height - @height
    @attr {x, y}
    this

  #registerCollisions: ->
  #  # Stop on solid objects
  #  @onHit('Solid', @stopMovement)
  #  @onHit('LevelEnd', @completeLevel)

  stopMovement: (data) ->
    if @_velocity && !@ducking
      console.log "collision w/ solid"
      #@x -= @_velocity.x

  #completeLevel: (data) ->
  #  endMarker = data[0].obj
  #  endMarker.collect()
}

Crafty.c "PlayerHitBox", {
  baseX: 3
  baseY: 42
  baseW: 46
  baseH: 63
  init: ->
    @requires("2D, Canvas, Collision")
      .attr({
              w: @baseW
              h: @baseH
              x: @baseX
              y: @baseY
            })
    #.debugAlpha(0.7)
    .registerCollisions()

  registerCollisions: ->
    # Stop on solid objects
    @onHit('Solid', @stopMovement)
    @onHit('LevelEnd', @completeLevel)

  stopMovement: (args...) ->
    @_parent.stopMovement(args...)

  completeLevel: (data) ->
    endMarker = data[0].obj
    endMarker.collect()
}
