---@class functions
local functions = {}

---@param factionId integer
---@return boolean|nil hasPlotMarker nil is an error 
function functions.hasPlotMarker(factionId)
    local dbTable = HebiDB:GetTable()
    for i, table in pairs(dbTable) do
        if i == 'factions' then
            for j, factions in dbTable[i] do
                if factions.factionId == factionId then
                    return factions.hasPlotMarker
                end
            end
        end
    end
    return nil
end

---@param factionId integer
---@return boolean|nil hasPlotMarker nil is an error 
function functions.setPlotMarker(factionId)
    local dbTable = HebiDB:GetTable()
    for i, table in pairs(dbTable) do
        if i == 'factions' then
            for j, factions in pairs(table) do
                if factions.factionId == factionId then
                    HebiDB.table[i][j].hasPlotMarker = not dbTable[i][j].hasPlotMarker
                end
            end
        end
    end
    return nil
end

---@param factionId integer
---@param cellDesc string
function functions.claimPlot(factionId, cellDesc)
    local dbTable = HebiDB:GetTable()
    for i, table in pairs(dbTable) do
        if i == 'factions' then
            for j, factions in pairs(table) do
                if factions.factionId == factionId then
                    HebiDB.table[i][j].plotCell = cellDesc
                    return 
                end
            end
        end
    end
end

---@param factionId integer
---@return boolean|nil hasPlot
function functions.hasPlot(factionId)
    local dbTable = HebiDB:GetTable()
    for _, table in pairs(dbTable) do
        for _, factions in pairs(table) do
            if factions.factionId == factionId and factions.plotCell then
                return factions.plotCell ~= ''
            end
        end
    end
    return nil
end

---@param pid integer
---@param factionId integer 
function functions.claimLand(pid, factionId)
    local playerCell = tes3mp.GetCell(pid)
    if not playerCell then return end
    for i, table in pairs(HebiDB.table) do
        for j, cellRecord in pairs(table) do
            if not cellRecord[playerCell] then
                functions.claimPlot(factionId, playerCell)
                HebiDB.table[i][j][playerCell] = not HebiDB.table[i][j][playerCell]
            end
        end
    end
end

return functions