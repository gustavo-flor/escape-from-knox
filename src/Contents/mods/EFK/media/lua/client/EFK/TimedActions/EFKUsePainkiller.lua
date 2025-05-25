require "TimedActions/ISBaseTimedAction"
require "EFK/Drugs"
require "EFK/Util/EventUtil"

EFKUsePainkiller = ISBaseTimedAction:derive("EFKUsePainkiller")

function EFKUsePainkiller:isValid()
    return self.character:getInventory():contains(self.item)
end

function EFKUsePainkiller:waitToStart()
    return false
end

function EFKUsePainkiller:update()
    self.item:setJobDelta(self:getJobDelta());
	self:setActionAnim(CharacterActionAnims.TakePills);
end

function EFKUsePainkiller:start()
    self.item:setJobType(getText("ContextMenu_Use_Painkiller"))
    self.item:setJobDelta(0.0);
	self:setOverrideHandModels(nil, self.item);
end

function EFKUsePainkiller:stop()
    ISBaseTimedAction.stop(self)
    self.item:setJobDelta(0.0)
end

function EFKUsePainkiller:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
    self.character:getXp():AddXP(Perks.Doctor, 5);
    local function onPainkillers()
        self.character:getBodyDamage():JustTookPainMeds()
    end
    EFKEventUtil.EveryOneMinuteUntil(onPainkillers, self.painkiller.duration)
    local usedDelta = 0
    if self.item:IsDrainable() then
        usedDelta = self.item:getUsedDelta() - self.item:getUseDelta()
        self.item:setUsedDelta(usedDelta)
    end
    if usedDelta <= 0 then
        self.character:getInventory():Remove(self.item)
    end
end

function EFKUsePainkiller:new(character, item)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.stopOnWalk = false
    o.painkiller = Drugs.painkillers[item:getFullType()]
    o.stopOnRun = true
    o.maxTime = o.painkiller.useTime
    return o
end
