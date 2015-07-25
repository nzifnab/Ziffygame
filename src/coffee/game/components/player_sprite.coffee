Crafty.c "PlayerSprite", {
  init: ->
    @requires('2D, Canvas, spr_player, SpriteAnimation')
      .reel("PlayerRunning", 200,
        [[4, 1], [4, 2]]
      )
      .reel("PlayerResting", 50000,
        [[4, 5], [5, 0]]
      )
      .reel("PlayerDucking", 1,
        [[5, 1]]
      )
      .reel("PlayerJumping", 500,
        [[5, 1], [5, 1], [5, 1], [4, 2]] # 4,6
      )
      .reel("PlayerFalling", 500,
        [[4, 3], [4, 4]]
      )
      .animate('PlayerResting', -1)

    @bind('NewDirection', (data) ->
      console.log {x: data.x, y: data.y}
      return if @ducking || @jumping
      if data.y != 0
        @animate('PlayerFalling', -1)
      else if data.x > 0
        @animate('PlayerRunning', -1)
      else if data.x < 0
        @animate('PlayerRunning', -1)
      else
        @animate('PlayerResting', -1)

      if data.x > 0
        @unflip('X')
      else if data.x < 0
        @flip('X')
    )

    @bind('PlayerDucking', (isDucking) ->
      if isDucking
        @animate("PlayerDucking", 1)
      else
        @animate("PlayerResting", -1)
    )

    @bind('PlayerJumping', ->
      #@pauseAnimation()
      @animate("PlayerJumping", 1)
    )

    @bind('StartAnimation', (data) ->
      @randomRest(data)
    )

    @bind('AnimationEnd', (data) ->
      @triggerJump(data)
    )

    @bind('FrameChange', (data) ->
      @randomRest(data)
      @adjustJumpHeight(data)
    )

  randomRest: (data) ->
    if data.id == 'PlayerResting'
      if Crafty.math.randomInt(1, 2) == 1 && @restStarted
        @flip('X')
      else if @restStarted
        @unflip('X')

      @restStarted = true
      @animationSpeed = Crafty.math.randomNumber(1, 10)

    else
      @restStarted = false
      @animationSpeed = 1

  triggerJump: (data) ->
    if data.id == 'PlayerJumping'
      @trigger("ExecutePlayerJump")

  adjustJumpHeight: (data) ->
    if data.id == "PlayerJumping"
      if data.currentFrame == 1
        @performDuck(true)
      else if data.currentFrame == 2
        @performDuck(false)
}
