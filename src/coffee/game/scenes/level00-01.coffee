Crafty.scene 'Level00-01', ((level) ->
  level.init()
  Crafty.e('LevelEnd').at(12, -1)

  # Place the player
  Crafty.e("Player").at(1, -1)

  @nextLevel = @bind 'LevelComplete', ->
    level.next()
), ->
  @unbind('LevelComplete', @nextLevel)
