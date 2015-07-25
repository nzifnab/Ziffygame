Crafty.scene 'Level00-01', ((level) ->
  level.init()

  #level.solidPlatform(
  #  x: 7
  #  y: -0.5
  #  w: 0.5
  #)
  #level.solidPlatform(
  #  x: 5
  #  y: -3
  #  w: 1
  #  h: 1
  #)
  #level.solidPlatform(
  #  x: 7.5
  #  y: -3
  #  w: 1.5
  #)
  #level.solidPlatform(
  #  x: 7.5
  #  y: -1.5
  #  w: 1
  #  h: 1
  #)
  #level.solidPlatform(
  #  x: 8.5
  #  y: -2
  #  w: 1
  #  h: 1
  #)

  Crafty.e('LevelEnd').at(12, -1)

  # Place the player
  Crafty.e("Player").at(1, -1.5)

  @nextLevel = @bind 'LevelComplete', ->
    level.next()
), ->
  @unbind('LevelComplete', @nextLevel)
