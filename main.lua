if not ResdaynCore then return end

---@class factions
local factions = {}
factions.tableConfig = require "custom.ResdaynFactions.config"
factions.functions = require "custom.ResdaynFactions.functions"

---@param pid integer
---@param name string
function factions.createFaction(pid, name)
    local faction = factions.tableConfig['factions']
    faction.factionId = factions.functions.generateFactionId()
    faction.name = name
    faction.leader = ResdaynCore.functions.getDbID(Players[pid].name)
    HebiDB:insertToTable('factions', {faction})
    factions.functions.changePlayerFaction(pid, faction.factionId)
end

---@param pid integer
---@param targetPid integer
function factions.invitePlayer(pid, targetPid)
    if not factions.functions.isLeader(pid) or targetPid == pid then return end
    local factionId = factions.functions.isInFaction(pid)
    factions.functions.changePlayerFaction(pid, factionId) 
end

---@param pid integer
function factions.leaveFaction(pid)
    if not pid then return end
    factions.functions.changePlayerFaction(pid, nil)
end

customCommandHooks.registerCommand("gquit", factions.leaveFaction)
customCommandHooks.registerCommand("createFaction", factions.createFaction)
customCommandHooks.registerCommand("invitePlayer", factions.invitePlayer)

return factions
