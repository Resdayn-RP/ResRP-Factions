if not ResdaynCore then return end

---@class factions
local factions = {}

factions.config = require "custom.ResdaynFactions.config"
factions.functions = require "custom.ResdaynFactions.functions"
factions.plots = require "custom.ResdaynFactions.plots.main"

---@param pid integer
---@param name table
function factions.createFaction(pid, name)
    if factions.functions.isInFaction(pid) then return end
    local faction = factions.config['factions']
    faction.factionId = factions.functions.generateFactionId()
    faction.name = factions.functions.concatenateName(name)
    faction.leader = ResdaynCore.functions.getDbID(Players[pid].name)
    HebiDB:insertToTable('factions', {faction})
    factions.functions.changePlayerFaction(pid, faction.factionId)
    HebiDB:writeTable()
end

---@param pid integer
---@param targetPid integer
function factions.invitePlayer(pid, targetPid)
    if not (factions.functions.isLeader(pid) and factions.functions.isInFaction(targetPid[2])) or targetPid[2] == pid then return end
    local factionId = factions.functions.isInFaction(pid)
    factions.functions.changePlayerFaction(targetPid[2], factionId) 
end

---@param pid integer
function factions.leaveFaction(pid)
    if not pid and factions.functions.isLeader(pid) then return end
    factions.functions.changePlayerFaction(pid, nil)
end

---@param pid integer
function factions.buyPlotMarkerCommand(pid)
    local factionId = factions.functions.isInFaction(pid)
    if not (factionId or factions.functions.isLeader(pid)) then return end
    factions.functions.RemoveFromBalance(pid, 0)
    factions.plots.functions.setPlotMarker(factionId)
end

---@param pid integer
function factions.claimLandCommand(pid)
    local factionId = not factions.functions.isInFaction(pid)
    if not (factionId or factions.functions.isLeader(pid)) then return end
    factions.plots.claimLand(pid, factionId)
end

---@param eventStatus table
function factions.onServerPostInit(eventStatus)
    local dbTable, cells = HebiDB:GetTable(), factions.config.claimableCells
    if dbTable.claimanbleCells then return eventStatus end

    HebiDB:insertToTable('claimableCells', { cells })
    HebiDB:writeTable()
    return eventStatus
end

customCommandHooks.registerCommand('buyPlotMarker', factions.buyPlotMarkerCommand)
customCommandHooks.registerCommand('claimLand', factions.claimLandCommand)
customCommandHooks.registerCommand("gquit", factions.leaveFaction)
customCommandHooks.registerCommand("createFaction", factions.createFaction)
customCommandHooks.registerCommand("invitePlayer", factions.invitePlayer)

customEventHooks.registerHandler("onServerPostInit", factions.onServerPostInit)

return factions
