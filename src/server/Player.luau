local ServerScriptService = game:GetService('ServerScriptService')
local Players = game:GetService('Players')
local Profile = require(ServerScriptService.Server.Profile)

-- listeners
-- entry point for player pipeline
Players.PlayerAdded:Connect(function(player)
	local profile = Profile.awaitCachedLoad(player)

	-- cleanup
	if player:IsDescendantOf(Players) then player.AncestryChanged:Wait() end
	profile:EndSession()
end)

return nil
