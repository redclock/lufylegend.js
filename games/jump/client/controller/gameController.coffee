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
            onDie: (player, index)=>
                @paused = true
        )
        @map = new Map()

    start: ->
        @paused = false
        @mapView = new MapView(@map, @game.backLayer)
        @playerView = new PlayerView(@player, @game.backLayer)

        LGlobal.stage.addEventListener(LMouseEvent.MOUSE_DOWN,
            (e)=>
                    @player.tryJump()
        );


    update: (dt)->
        if @paused
            return
        deltaTime = dt / gameDefines.STEP_TIME
        @player.update(deltaTime, @map)
        @playerView.refreshView()
        @mapView.update(@player.getCurrentX())

module.exports = GameController
