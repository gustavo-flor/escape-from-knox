EFKInjectorsEventUtil = {}

function EFKInjectorsEventUtil.EveryOneMinuteUntil(callback, maxDuration)
    local duration = 0
    local function listener()
        callback()
        duration = duration + 1
        if duration >= maxDuration then
            Events.EveryOneMinute.Remove(listener)
            duration = 0
        end
    end
    Events.EveryOneMinute.Add(listener)
end
