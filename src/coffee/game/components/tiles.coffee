Crafty.c "Tile", {
  init: ->
    @requires('2D, Canvas, Grid')
      .attr(
        w: Game.gameGrid.tile.width
        h: Game.gameGrid.tile.height
      )
}

Crafty.c "Grass", {
  init: ->
    @requires('spr_grass, Floor, Tile, Solid')
}

Crafty.c "Dirt", {
  init: ->
    @requires('spr_dirt, Tile, Solid')
}

Crafty.c "LevelEnd", {
  init: ->
    @requires('spr_level_end, Tile')

  collect: ->
    @destroy()
    Crafty.trigger("LevelComplete", this)
}
