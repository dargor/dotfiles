local cursorLocator = {
    duration = 0.65,
    fps = 60,
    startRadius = 18,
    endRadius = 180,
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

local function animateCursorRing(delay)
    delay = delay or 0

    hs.timer.doAfter(delay, function()
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
            local easedProgress = easeOutCubic(progress)

            local radius =
                cursorLocator.startRadius +
                (cursorLocator.endRadius - cursorLocator.startRadius)
                * easedProgress

            local diameter = radius * 2

            ring:setFrame({
                x = position.x - radius,
                y = position.y - radius,
                w = diameter,
                h = diameter,
            })

            ring:setStrokeColor({
                red = cursorLocator.color.red,
                green = cursorLocator.color.green,
                blue = cursorLocator.color.blue,
                alpha = 1 - progress,
            })

            if progress >= 1 then
                removeAnimation(animation)
            end
        end)
    end)
end

local function showCursorLocator()
    animateCursorRing(0)
    animateCursorRing(0.1)
    animateCursorRing(0.2)
end

hs.hotkey.bind({ "alt", "shift" }, "space", showCursorLocator)
