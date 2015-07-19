Crafty.c "Player", {
  width: Game.gameGrid.tile.width * 0.75
  height: Game.gameGrid.tile.height * 1.5
  init: ->
    @requires('spr_player, 2D, Canvas, Multiway, Collision, Gravity, SpriteAnimation')
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
      # The hitbox of our little alien
      .collision([3, 39], [45, 39], [45, 96], [3, 96])
      .registerCollisions()
      .gravity("Floor")
      .gravityConst(Game.gravityConst)
      .reel("PlayerRunning", 200,
        [[4, 1], [4, 2]]
      )
      .reel("PlayerResting", 50000,
        [[5, 0], [4, 5]]
      )
      .animate('PlayerResting')

    @bind('NewDirection', (data) ->
      if data.x > 0
        @unflip('X')
        @animate('PlayerRunning', -1)
      else if data.x < 0
        @flip('X')
        @animate('PlayerRunning', -1)
      else
        @animate('PlayerResting', -1)
    )

    @bind('StartAnimation', (data) ->
      @randomRest(data)
    )

    @bind('FrameChange', (data) ->
      @randomRest(data)
    )

  at: (x, y) ->
    transX = Game.playAreaX()
    transY = (Game.gameGrid.height - Game.gameGrid.baseFloorHeight + 1)
    x = x * Game.gameGrid.tile.width + transX * Game.gameGrid.tile.width
    y = y * Game.gameGrid.tile.height + transY * Game.gameGrid.tile.height - @height
    @attr {x, y}
    this

  randomRest: (data) ->
    if data.id == 'PlayerResting'
      @animationSpeed = Crafty.math.randomNumber(1, 10)
    else
      @animationSpeed = 1

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
