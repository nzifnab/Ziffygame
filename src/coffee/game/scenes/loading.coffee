assetsMap = {
  "sprites": {
    "assets/img/tiles_sprites.png": {
      tile: 70
      tileh: 70
      map: {
        spr_grass: [7,8],
        spr_dirt: [8,12],
        spr_level_end: [1, 0]
      }
      paddingX: 2
      paddingY: 2
    },
    "assets/img/characters/player/rest_sprites.png": {
      tile: 395
      tileh: 512
      map: {
        spr_player: [0,0]
      }
      paddingX: 0
      paddingY: 0
    }
  }
}

Crafty.scene("Loading", (->
  Crafty.e('2D, DOM, Text')
    .text('Loading...')
    .attr(x: 0, y: Game.height() / 2 - 24, w: Game.width())
    .textFont(size: '34px', family: 'Arial', color: 'white')

  Crafty.load assetsMap, ->
    Game.level().next()

))
