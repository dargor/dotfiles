local cursorLocator = {
    duration = 0.9,
    fps = 60,
    startRadius = 18,
    endRadius = 180,
    reboundRadius = 34,
    strokeWidth = 7,

    color = {
        red = 1,
        green = 0.15,
        blue = 0.1,
        alpha = 1,
    },

    animations = {},
}

local function easeOutCubic(t)
    return 1 - ((1 - t) ^ 3)
end

local function easeInCubic(t)
    return t ^ 3
end

local function lerp(from, to, progress)
    return from + (to - from) * progress
end

local function removeAnimation(animation)
    if animation.timer then
        animation.timer:stop()
        animation.timer = nil
    end

    for _, ring in ipairs(animation.rings) do
        ring:delete()
    end

    animation.rings = {}
end

local function createRing(position)
    local diameter = cursorLocator.startRadius * 2

    return hs.drawing.circle({
            x = position.x - cursorLocator.startRadius,
            y = position.y - cursorLocator.startRadius,
            w = diameter,
            h = diameter,
        })
        :setFill(false)
        :setStroke(true)
        :setStrokeWidth(cursorLocator.strokeWidth)
        :setStrokeColor(cursorLocator.color)
        :setBehavior(
            hs.drawing.windowBehaviors.canJoinAllSpaces +
            hs.drawing.windowBehaviors.stationary
        )
        :setLevel(hs.drawing.windowLevels.overlay)
        :show()
end

local function showCursorLocator()
    local position = hs.mouse.absolutePosition()
    local ring = createRing(position)

    local animation = {
        rings = { ring },
        timer = nil,
        frame = 0,
    }

    table.insert(cursorLocator.animations, animation)

    local totalFrames =
        math.max(1, math.floor(cursorLocator.duration * cursorLocator.fps))

    animation.timer = hs.timer.doEvery(1 / cursorLocator.fps, function()
        animation.frame = animation.frame + 1

        local progress = math.min(animation.frame / totalFrames, 1)
        local radius

        if progress < 0.5 then
            local phase = progress / 0.5

            radius = lerp(
                cursorLocator.startRadius,
                cursorLocator.endRadius,
                easeOutCubic(phase)
            )
        elseif progress < 0.85 then
            local phase = (progress - 0.5) / 0.35

            radius = lerp(
                cursorLocator.endRadius,
                cursorLocator.startRadius,
                easeInCubic(phase)
            )
        else
            local phase = (progress - 0.85) / 0.15

            if phase < 0.5 then
                radius = lerp(
                    cursorLocator.startRadius,
                    cursorLocator.reboundRadius,
                    easeOutCubic(phase * 2)
                )
            else
                radius = lerp(
                    cursorLocator.reboundRadius,
                    cursorLocator.startRadius,
                    easeInCubic((phase - 0.5) * 2)
                )
            end
        end

        local diameter = radius * 2

        ring:setFrame({
            x = position.x - radius,
            y = position.y - radius,
            w = diameter,
            h = diameter,
        })

        local alpha

        if progress < 0.72 then
            alpha = 1
        else
            alpha = 1 - ((progress - 0.72) / 0.28)
        end

        ring:setStrokeColor({
            red = cursorLocator.color.red,
            green = cursorLocator.color.green,
            blue = cursorLocator.color.blue,
            alpha = math.max(0, alpha),
        })

        if progress >= 1 then
            removeAnimation(animation)
        end
    end)
end

hs.hotkey.bind({ "alt", "shift" }, "space", showCursorLocator)
