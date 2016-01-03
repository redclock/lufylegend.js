# Created by yaochunhui on 16/1/1.
gameDefines     = require '../base/gameDefines'
Map             = require '../model/map'
Player          = require '../model/player'
PlayerView      = require '../view/playerView'
MapView         = require '../view/mapView'

class GameController
    constructor: (@game)->
        @player = new Player(
            onHitFloor: (player, index)=>
                @mapView.onPlayerHitFloor(index)
        )
        @map = new Map()

    start: ->
        @mapView = new MapView(@map, @game.backLayer)
        @playerView = new PlayerView(@player, @game.backLayer)

        LGlobal.stage.addEventListener(LKeyboardEvent.KEY_DOWN,
            (e)=>
                if e.keyCode == 32
                    @player.tryJump()
        );


    update: (dt)->
        deltaTime = dt / gameDefines.JUMP_TIME
        @player.update(deltaTime, @map)
        @playerView.refreshView()
        @mapView.update(@player.getCurrentX())

module.exports = GameController
