# Created by yaochunhui on 16/1/1.
class Map
    constructor: ->
        @floors = [0, 0, 0, 1, 2, 1, 0, -1, -1, 0, 1, 1, 1, -1, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 2]

    getFloor: (index) ->
        if 0 <= index < @floors.length
            @floors[index]
        else
            0

module.exports = Map
