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
end

---@param pid integer
---@param targetPid integer
function factions.invitePlayer(pid, targetPid)
    if not factions.functions.isLeader(pid) or targetPid == pid then return end

    local dbTable = HebiDB.Table

    for i, table in pairs(dbTable) do
        for j, faction in pairs(table) do
            if faction.leader == ResdaynCore.functions.getDbID(Players[pid].name) then 
                TableHelper.insertValues(HebiDB.Table[i][j], ResdaynCore.functions.getDbID(Players[targetPid].name), true)
            end
        end
    end
end

customCommandHooks.registerCommand("createFaction", factions.createFaction)
customCommandHooks.registerCommand("invitePlayer", factions.invitePlayer)

return factions
