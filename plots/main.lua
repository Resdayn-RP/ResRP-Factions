---@class plots
local plots = {}

plots.functions = require('custom.ResdaynFactions.plots.functions') 

---@param pid integer
---@param factionId integer
function plots.claimLand(pid, factionId)
    if not pid then return end
    if not plots.functions.hasPlotMarker(pid) and plots.functions.hasPlot(factionId) then return end

    plots.functions.claimLand(pid, factionId)
    plots.functions.setPlotMarker(factionId)
end

return plots