# Created by yaochunhui on 16/1/2.
gameDefines = require '../base/gameDefines'

class MapView
    constructor: (@model, parentView) ->
        @rootNode = new LSprite()
        @rootNode.x = gameDefines.CENTER_X
        @rootNode.y = gameDefines.CENTER_Y
        @minIndex = @maxIndex = 0

        parentView.addChild(@rootNode)

    update: (centerX)->
        screenWidth = LGlobal.width
        WIDTH = gameDefines.FLOOR_WIDTH
        halfScreenWidth = screenWidth / 2
        minIndex = Math.floor(centerX - halfScreenWidth / WIDTH)
        maxIndex = Math.ceil(centerX + halfScreenWidth / WIDTH)
        while (pillar = @rootNode.childList[0]) and (pillar.floorIndex < minIndex)
            @rootNode.removeChildAt(0)

        addIndex =
            if @rootNode.numChildren == 0
                minIndex
            else
                @rootNode.childList[@rootNode.numChildren - 1].floorIndex
        for i in [addIndex+1..maxIndex] by 1
            @createPillar(i)

        @rootNode.x = gameDefines.CENTER_X - (centerX) * WIDTH

    createPillar: (index)->
        height = -@model.getFloor(index) * gameDefines.FLOOR_HEIGHT
        WIDTH = gameDefines.FLOOR_WIDTH * 0.75

        pillarNode = new LSprite()
        pillarNode.floorIndex = index
        pillarNode.x = index * gameDefines.FLOOR_WIDTH
        pillarNode.y = height
        pillarNode.orgY = height
        @rootNode.addChild(pillarNode)
        shapeNode = new LShape()
        pillarNode.addChild(shapeNode)

        shapeNode.graphics.drawEllipse 1, "#000000",
            [-WIDTH / 2, -5, WIDTH, 10]
        shapeNode.graphics.drawLine 1, "#000000",
            [-WIDTH / 2, 0, -WIDTH / 2, 800]
        shapeNode.graphics.drawLine 1, "#000000",
            [WIDTH / 2, 0, WIDTH / 2, 800]
        pillarNode

    getPillarByIndex: (index) ->
        for pillar in @rootNode.childList
            return pillar if pillar.floorIndex == index
        null

    shakePillar: (pillar)->
        LTweenLite
        .to(pillar, 0.05, {y: pillar.orgY + 10})
        .to(pillar, 0.2, {y: pillar.orgY})

    onPlayerHitFloor: (index)->
        pillar = @getPillarByIndex(index)
        return unless pillar
        @shakePillar(pillar)

module.exports = MapView