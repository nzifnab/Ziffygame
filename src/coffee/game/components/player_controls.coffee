Crafty.c "PlayerControls", {
  baseSpeed: 4
  jumpSpeed: Game.gameGrid.tile.height * 0.09375#6

  init: ->
    @requires('Keyboard')
    @_velocity = {x: 0, y: 0}

  bindMovementControls: ->
    @_controls_bindControls()

    # Apply movement if key is down when created
    for k in [Crafty.keys.LEFT_ARROW, Crafty.keys.RIGHT_ARROW, Crafty.keys.A, Crafty.keys.D]
      if Crafty.keydown[k]
        @trigger "KeyDown", {
          key: k
        }

    this

  _controls_bindControls: ->
    @unbind "KeyDown", @_controls_keydown
    @unbind "KeyUp", @_controls_keyup
    @unbind "EnterFrame", @_controls_enterframe
    @unbind "PlayerDucking", @performDuck
    @unbind "ExecutePlayerJump", @performJump
    @bind "KeyDown", @_controls_keydown
    @bind "KeyUp", @_controls_keyup
    @bind "EnterFrame", @_controls_enterframe
    @bind "PlayerDucking", @performDuck
    @bind "ExecutePlayerJump", @performJump

  _controls_enterframe: (e) ->
    x = @_velocity.x
    if @_velocity.y >= @_terminalVelocity
      @_velocity.y = @_terminalVelocity
    y = @_velocity.y

    if @ducking || @jumping
      x = 0

    if x != 0
      @x += x
      moved = true


    if y != 0
      moved = true
      @jumping = false
      @y += y

    if Game.Utility.negativeCheck(x) != Game.Utility.negativeCheck(@_velocity.previousX) || Game.Utility.negativeCheck(y) != Game.Utility.negativeCheck(@_velocity.previousY)
      @trigger("NewDirection",
        x: x
        y: y
        previousX: @_velocity.previousX
        previousY: @_velocity.previousY
      )

    @_velocity.previousX = x
    @_velocity.previousY = y

    if moved
      @trigger("Moved", {
        x: @x - x
        y: @y - y
      })

  _controls_keydown: (e) ->
    if (e.key == Crafty.keys.LEFT_ARROW || e.key == Crafty.keys.A)
      @_left_key_clicked = true
      @_velocity.x += -@baseSpeed
    else if (e.key == Crafty.keys.RIGHT_ARROW || e.key == Crafty.keys.D)
      @_right_key_clicked = true
      @_velocity.x += @baseSpeed

    if !@ducking && !@jumping
      if (e.key == Crafty.keys.DOWN_ARROW || e.key == Crafty.keys.S)
        @duck()

      if (e.key == Crafty.keys.UP_ARROW || e.key == Crafty.keys.W)
        @jump()

  _controls_keyup: (e) ->
    if e.key == Crafty.keys.LEFT_ARROW || e.key == Crafty.keys.A
      @_velocity.x -= -@baseSpeed if @_left_key_clicked
    else if e.key == Crafty.keys.RIGHT_ARROW || e.key == Crafty.keys.D
      @_velocity.x -= @baseSpeed if @_right_key_clicked

    if @ducking && (e.key == Crafty.keys.DOWN_ARROW || e.key == Crafty.keys.S) && !Crafty.keydown[Crafty.keys.DOWN_ARROW] && !Crafty.keydown[Crafty.keys.S]
      @stand()

  duck: ->
    if @_velocity.y == 0
      @trigger("PlayerDucking", true)
      @ducking = true

  jump: ->
    if @_velocity.y == 0
      @trigger("PlayerJumping")
      @jumping = true

  performJump: ->
    @_velocity.y = -@jumpSpeed

  stand: ->
    @trigger("PlayerDucking", false)
    @ducking = false

  performDuck: (isDucking) ->
    if isDucking
      @y += @attr('h') * 0.25
      @attr('h', @attr('h') * 0.75)
      #@collision(3, 49, 46, (105*0.75 - 42*0.75+10))
      @setHitbox(3, 44, 46, (@_h - 44))
      #@collision([3, 42*0.75+10], [49, 42*0.75+10], [49, 105*0.75], [3, 105*0.75])
    else
      @y -= (@height - @attr('h'))
      @attr('h', @height)
      @setHitbox()
      #.collision([3, 42], [49, 42], [49, 105], [3, 105])
}
