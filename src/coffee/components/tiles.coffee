Crafty.c "Tile", {
  init: ->
    @requires('2D, Canvas, Grid')
}

Crafty.c "Grass", {
  init: ->
    @requires('Floor, Tile, Color, Solid')
    @color('rgb(255, 0, 0)')
}

Crafty.c "Dirt", {
  init: ->
    @requires('Tile, Color, Solid')
    @color('rgb(20, 185, 40)')
}
