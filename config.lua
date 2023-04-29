---@class config
local config = {}

config['factions'] = {
    name = nil,
    factionId = nil,
    members = {},
    leader = nil,
    balance = 0,
    hasPlotItem = false,
    plotCell = '',
}

config.claimableCells = {
    ['Ald-ruhn, Morag Tong Guildhall'] = false,
}

return config