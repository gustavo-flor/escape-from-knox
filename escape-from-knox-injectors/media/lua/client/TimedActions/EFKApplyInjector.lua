require "TimedActions/ISBaseTimedAction"

EFKApplyInjector = ISBaseTimedAction:derive("EFKApplyInjector")

function EFKApplyInjector:isValid()
    return self.character:getInventory():contains(self.item)
end

function EFKApplyInjector:waitToStart()
    return false
end

function EFKApplyInjector:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function EFKApplyInjector:start()
    self:setActionAnim(CharacterActionAnims.TakePills)
    self:setOverrideHandModels(nil, self.item)
    self.item:setJobType(getText("ContextMenu_Apply_Injector"))
    self.item:setJobDelta(0.0)
end

function EFKApplyInjector:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

function EFKApplyInjector:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    self.character:getXp():AddXP(Perks.Doctor, 5)
    print(item:getName() .. " Injected")
    self.character:getInventory():Remove(self.item)
end

function EFKApplyInjector:new(character, item, bodyPart)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = 120
    return o
end
