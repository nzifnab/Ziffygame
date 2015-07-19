# Grid component allows an element to be
# located on a grid of tiles
Crafty.c "Grid", {
  init: ->
    @attr {
      w: Game.gameGrid.tile.width,
      h: Game.gameGrid.tile.height
    }

  # Locate this entity at the given position on the grid
  # For our purposes we are translating the x/y coord system
  # of canvas such that 0,0 is the bottom-left-most "base floor playable area".
  at: (x, y) ->
    transX = Game.playAreaX()
    transY = (Game.gameGrid.height - Game.gameGrid.baseFloorHeight)
    x = x * Game.gameGrid.tile.width + transX * Game.gameGrid.tile.width
    y = y * Game.gameGrid.tile.height + transY * Game.gameGrid.tile.height
    @attr {x, y}
    this
}
