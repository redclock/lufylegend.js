# Created by yaochunhui on 16/1/1.
class Game
    init: ->
        @_registerControllers()
        LInit(20,"legend",800,450, => @_initEngine());

    _registerControllers: ->
        controllerClasses = {
            gameLogic: require './gameController'
        }
        @controllers = {}
        for name, cls of controllerClasses
            @controllers[name] = new cls(@)
        return

    _initEngine: ->
        @backLayer = new LSprite()
        addChild(@backLayer)
        @curTime = Date.now()
        for name, controller of @controllers
            controller.start()
        console.log LGlobal.width + " " + LGlobal.height
        @backLayer.graphics.drawRect(1, "#000000", [1, 1, 799, 449])
        @backLayer.addEventListener(LEvent.ENTER_FRAME, @update.bind(@))


    update: ->
        newTime = Date.now()
        deltaTime = newTime - @curTime
        @curTime = newTime
        deltaTime = Math.min(deltaTime, 100)
        for name, controller of @controllers
            controller.update(deltaTime / 1000)

        return
module.exports = Game
