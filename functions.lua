---@class functions
local functions = {}

---@param message table
---@return string text
function functions.concatenateName(message)
    local text = ""
    for i, j in pairs(message) do
        if i ~= 1 then
            text = text .. " " .. j
        end
    end
    return text
end

---@param name string
---@return integer|nil dbid
function functions.getGroupId(name)
    local factionTable = HebiDB:getTable()
    for _, Table in pairs(factionTable) do
        for _, faction in pairs(Table) do
            if faction.name == name then return faction.factionId end
        end
    end
    return nil
end     

---@param pid integer
---@return boolean isLeader
function functions.isLeader(pid)
    local factionTable = HebiDB:getTable()
    for _, table in pairs(factionTable) do
        for _, faction in pairs(table) do
            if faction.leader == ResdaynCore.functions.getDbID(Players[pid].name) then return true end
        end
    end
    return false
end

---@param id integer
---@return boolean isUnique
function functions.checkForUniqueGroupID(id)
    local factionTables = HebiDB:getTable()
    for _, table in pairs(factionTables) do
        for _, faction in pairs(table) do
            if faction.factionId == id then return false end
        end
    end
    return true
end

---@return integer id
function functions.generateFactionId()
    local id = math.random(0, 999)
    repeat
        id = math.random(0, 999)
    until functions.checkForUniqueGroupID(id)
    return id
end

---@param pid integer
---@return integer|nil isInFaction
function functions.isInFaction(pid)
    local dbTable = HebiDB:getTable()
    for _, table in pairs(dbTable) do
        for _, player in pairs(table) do
            if Players[pid].name == player.name and player.factionId then return player.factionId end
        end
    end
    return nil
end

---@param source integer SourcePlayerId
---@param target integer TargetPlayerId
---@return boolean isSameFaction
function functions.isPartOfSameFaction(source, target)
    if not target then return false end
    local sourceFac, targetFac = functions.isInFaction(source), functions.isInFaction(target)
    if not (sourceFac or targetFac) and sourceFac == targetFac then return true end
    return false
end

---@param target integer target player id
---@param factionId integer|nil faction id
function functions.changePlayerFaction(target, factionId)
    if not target then return end
    
    for i, table in pairs(HebiDB.Table) do
        for j, player in pairs(table) do
            if player.name == Players[target].name then
                HebiDB.Table[i][j].factionId = factionId
                return
            end
        end
    end
end

---@param pid number
---@param cmd table
function functions.addToBalance(pid, cmd)
    local faction = functions.isInFaction(pid)
    if not (faction or cmd[2]) then return end
    
    local dbId = ResdaynCore.functions.getDbId(Players[pid].name)

    ResdaynCore.functions.removeMoney(dbId, tonumber(cmd[2]))

    for i, table in pairs(HebiDB.Table) do
        for j, faction in pairs(table) do
            if faction.factionId == faction then
                HebiDB.Table[i][j] = faction.balance + tonumber(cmd[2])
            end
        end
    end
end

---@param pid number
---@param amount integer
function functions.RemoveFromBalance(pid, amount)
    local faction = functions.isInFaction(pid)
    if not (faction or cmd[2] or functions.isLeader(pid)) then return end

    local dbId = ResdaynCore.functions.getDbId(Players[pid].name)

    ResdaynCore.functions.addMoney(dbId, amount)

    for i, table in pairs(HebiDB.Table) do
        for j, faction in pairs(table) do
            if faction.factionId == faction then
                HebiDB.Table[i][j] = faction.balance - tonumber(amount)
            end
        end
    end
end

return functions