local ServerScriptService = game:GetService('ServerScriptService')
local Players = game:GetService('Players')
local Profile = require(ServerScriptService.Server.Profile)

-- listeners
-- entry point for player pipeline
Players.PlayerAdded:Connect(function(player)
	local success, result = pcall(Profile.awaitCachedLoad, player)
	if not success then
		player:Kick(`Was not possible load your data:\n{result}`)
		return
	end

	local profile = result

	-- cleanup
	if player:IsDescendantOf(Players) then player.AncestryChanged:Wait() end
	profile:EndSession()
end)

return nil
