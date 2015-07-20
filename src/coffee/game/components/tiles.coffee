Crafty.c "Tile", {
  spriteW: 70
  spriteH: 70

  init: ->
    @requires('2D, Canvas, Grid')
      .attr(
        w: Game.gameGrid.tile.width
        h: Game.gameGrid.tile.height
      )#.collision('Nothing')

  half: (horizontal=null, vertical=null) ->
    console.log "@w = #{@w}, @h = #{@h}"
    console.log "horizontal = #{horizontal}, vertical = #{vertical}"
    x = if horizontal == 'left' || !horizontal then 0 else @w / 2
    y = if vertical == 'top' || !vertical then 0 else @h / 2
    w = if horizontal then @w / 2 else @w
    h = if vertical then @h / 2 else @h
    console.log "x = #{x}, y = #{y}, w = #{w}, h = #{h}"
    @crop(x, y, w, h)
   # @collision()
}

Crafty.c "Grass", {
  init: ->
    @requires('Solid, spr_grass, Floor, Tile')
}

Crafty.c "Dirt", {
  init: ->
    @requires('Solid, spr_dirt, Tile')
}

Crafty.c "LevelEnd", {
  init: ->
    @requires('spr_level_end, Tile')

  collect: ->
    @destroy()
    Crafty.trigger("LevelComplete", this)
}
