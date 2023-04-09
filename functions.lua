---@class functions
local functions = {}

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
        for _, faction in pairs(Table) do
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

return functions