Crafty.scene 'Level00-01', ((level) ->
  level.init()
  #Crafty.e('Grass').at(9, -3).halfWidth()
  #for i in [-2..-1]
  #  Crafty.e('Dirt').at(9, i).halfWidth()

  #Crafty.e('Grass').at(8.5, -1.5).half('right', 'top')
  #Crafty.e('Dirt').at(8.5, -1).half('right')

  #Crafty.e('Grass').at(9.5, -3).halfWidth('right')
  #for i in [-2..-1]
  #  Crafty.e('Dirt').at(9.5, i).halfWidth('right')
  #level.solidPlatform(
  #  x: 7
  #  y: -0.5
  #  w: 0.5
  #)
  level.solidPlatform(
    x: 5
    y: -3
    w: 1
    h: 1
  )
  #level.solidPlatform(
  #  x: 7.5
  #  y: -3
  #  w: 1.5
  #)

  Crafty.e('LevelEnd').at(12, -1)

  # Place the player
  Crafty.e("Player").at(1, -1)

  @nextLevel = @bind 'LevelComplete', ->
    level.next()
), ->
  @unbind('LevelComplete', @nextLevel)
