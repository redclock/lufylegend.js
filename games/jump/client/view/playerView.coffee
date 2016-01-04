# Created by yaochunhui on 16/1/1.
gameDefines = require '../base/gameDefines'
radius = 18

class PlayerView
    constructor: (@model, parentView) ->
        @rootNode = new LSprite()
        parentView.addChild(@rootNode)

        @shape = new LShape()
        @shape.graphics.drawEllipse(0, "#FF0000", [-radius / 2, -radius, radius, radius], true, "#880000");

        @rootNode.addChild @shape
        @rootNode.x = gameDefines.CENTER_X
        @rootNode.y = gameDefines.CENTER_Y
        @refreshView()

    refreshView: ->
        @shape.x = 0
        @shape.y = -@model.y * gameDefines.FLOOR_HEIGHT

module.exports = PlayerView
