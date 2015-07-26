Crafty.c "GravityVelocity", {
  _gravityConst: 0.2
  _anti: null

  init: ->
    @requires('2D')

  gravity: (stopOnComponent) ->
    @_anti = stopOnComponent if stopOnComponent
    @bind("EnterFrame", @_gravity_enterframe)
    return this

  gravityConst: (g) ->
    @_gravityConst = g
    return this

  terminalVelocity: (v) ->
    @_terminalVelocity = v
    this

  _gravity_enterframe: ->
    @_velocity.y += @_gravityConst if @_falling

    pos = @hitbox.pos()
    # Make sure to search the whole space before and after
    # velocity
    pos._h += @_velocity.y + @_gravityConst + 1
    # map.search wants _x, intersect wants x... wat.
    #pos.x = pos._x
    #pos.y = pos._y
    #pos.w = pos._w
    #pos.h = pos._h

    objects = Crafty.map.search(pos)

    for obj in objects
      # Check for intersection directly below player
      if @willFloorCollide(obj, @_velocity.y)#obj != this && obj.has(@_anti) && obj.intersect(pos)
        hit = obj
        break

    if hit
      if @_falling
        @stopFalling(hit)
    else
      @_falling = true

  willFloorCollide: (obj, verticalSpeed)->
    return false if obj == this
    return false unless obj.has(@_anti)
    #console.log "testing"
    #x: 210, y: 350, w: 70, h: 70
    #console.log obj
    #console.log "hitbox:"
    #console.log @hitbox
    #x: 213
    #y: 294
    #w: 46
    #h: 63
    #throw 'stop'
    #console.log "=========================="
    #console.log "y: #{@hitbox._y}"
    #console.log "bottom y: #{@hitbox._y + @hitbox._h}"
    #console.log "bottom y after velocity: #{@hitbox._y + @hitbox._h + @_velocity.y}"
    #console.log "obj y: #{obj.y}"
    #console.log "y velocity: #{@_velocity.y}"
    #throw "stop"
    if(
      @_velocity.y >= 0 &&
      # This is already part of intersect...
      (@hitbox._x + @hitbox._w > obj.x) &&
      # So is this
      (@hitbox._x < obj.x + obj.h) &&
      # before velocity... are we *above* the platform
      (@hitbox._y + @hitbox._h) <= obj.y &&
      # after velocity, are we *below* it
      (@hitbox._y + @hitbox._h + @_velocity.y + @_gravityConst + 1) > obj.y
    )
      return true

  stopFalling: (e) ->
    @y = e._y - @_h - 1 # move object to top of floor
    @_velocity.y = 0
    @_falling = false
    @trigger('FallingStopped')
}
