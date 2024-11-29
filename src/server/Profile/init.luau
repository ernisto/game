-- packages
local ServerScriptService = game:GetService('ServerScriptService')
local ProfileStore = require(ServerScriptService.Packages.ProfileStore)
local template = require(script.template)

-- module
local playersStore = ProfileStore.New('players', template)
local profiles = {}
local loadings = {}
local Profile = {}

-- builder
function Profile.awaitCachedLoad(player: Player)
	while loadings[player] do
		task.wait()
	end
	if profiles[player] then return profiles[player] end

	loadings[player] = true
	local self = playersStore:StartSessionAsync(tostring(player.UserId), {})
	loadings[player] = nil

	-- profile handling
	if not self then
		player:Kick(`wasnt possible load your data`)
		error(`generic ProfileStore error`)
	end
	self.OnSessionEnd:Connect(function()
		player:Kick(`session stealed by another server`)
		profiles[player] = nil
	end)

	-- start up
	self:AddUserId(player.UserId)
	self:Reconcile()

	-- end
	profiles[player] = self
	return self
end

-- end
return Profile
