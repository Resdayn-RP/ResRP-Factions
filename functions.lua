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

return functions