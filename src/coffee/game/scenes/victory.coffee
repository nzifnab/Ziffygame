Crafty.scene('Victory', (->
  Crafty.e('2D, DOM, Text')
    .attr(x: 100, y: 100)
    .text("Victory!")
    .textFont(size: '34px', family: 'Arial', color: 'white')

  @restartGame = @bind('KeyDown', ->
    Game.restart()
  )
), ->
  @unbind("KeyDown", @restartGame)
)
