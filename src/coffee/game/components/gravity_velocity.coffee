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

  _gravity_enterframe: ->
    @_velocity.y += @_gravityConst if @_falling

    pos = @pos()
    # Look one lower to make sure we're on the 'floor'
    pos._y += 1
    # map.search wants _x, intersect wants x... wat.
    pos.x = pos._x
    pos.y = pos._y
    pos.w = pos._w
    pos.h = pos._h

    objects = Crafty.map.search(pos)

    for obj in objects
      # Check for intersection directly below player
      if obj != this && obj.has(@_anti) && obj.intersect(pos)
        hit = obj
        break

    if hit
      if @_falling
        @stopFalling(hit)
    else
      @_falling = true

  stopFalling: (e) ->
    console.log "Collision with floor"
    @y = e._y - @h # move object to top of floor
    @_velocity.y = 0
    @_falling = false
    @trigger('FallingStopped')
}
