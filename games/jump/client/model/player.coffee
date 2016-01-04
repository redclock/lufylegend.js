# Created by yaochunhui on 15/12/29.
gameDefines = require '../base/gameDefines'
half_gravity = gameDefines.GRAVITY / 2
duration_delta = gameDefines.JUMP_DURATION_DELTA

class Player
    constructor: (@listener)->
        @reset()

    update: (delta, map)->
        @timer += delta
        t = @timer
        floors = [
            map.getFloor(@curFloorIndex)
            map.getFloor(@curFloorIndex + 1)
            map.getFloor(@curFloorIndex + 2)
        ]

        if @isJumping
            if floors[1] > floors[0]
                vel = (floors[1] - floors[0]) - half_gravity
                duration = 1
                willDie = false
            else if floors[2] > floors[0]
                vel = -half_gravity * 2
                duration = 2
                willDie = true
            else
                vel = (floors[2] - floors[0]) / 2 - half_gravity * 2
                duration = 2
                willDie = false
        else
            if floors[1] > floors[0]
                vel = -half_gravity
                duration = 1
                willDie = true
            else
                vel = (floors[1] - floors[0]) - half_gravity
                duration = 1
                willDie = false

        @y = (vel * t + half_gravity * t * t + floors[0])

        if @isPendingJump
            if t < duration_delta
                @isJumping = true
            else if t > duration - duration_delta
                @willJump = true
            @isPendingJump = false

        if willDie and @timer >= duration - 0.3 and @y <= floors[duration]

            @listener?.onDie?(@, @curFloorIndex + duration)
            return

        if @timer >= duration
            @timer -= duration
            @y = floors[duration]
            @curFloorIndex += duration
            @isJumping = @willJump
            @willJump = false
            @listener?.onHitFloor?(@, @curFloorIndex)

    tryJump: ->
        @isPendingJump = true

    reset: ->
        @y = 0
        @timer = 0
        @curFloorIndex = 0
        @isJumping = false
        @willJump = false
        @isPendingJump = false

    getCurrentX: ->
        @curFloorIndex + @timer



module.exports = Player

