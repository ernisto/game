-- packages
local ServerScriptService = game:GetService('ServerScriptService')
local ProfileStore = require(ServerScriptService.Packages.ProfileStore)

local template = require(script.template)
export type data = typeof(template)

-- module
local playersStore = ProfileStore.New('players', template)
local profiles = {}
local loadings = {}
local Profile = {}

-- builder
function Profile.awaitCachedLoad(player: Player): ProfileStore.Profile<data>
	while loadings[player] do
		task.wait()
	end
	if profiles[player] then return profiles[player] end

	loadings[player] = true
	local self = playersStore:StartSessionAsync(tostring(player.UserId), {})
	loadings[player] = nil

	assert(self, `generic ProfileStore error`)

	-- start up
	self:AddUserId(player.UserId)
	self:Reconcile()

	-- cache
	profiles[player] = self
	self.OnSessionEnd:Connect(function()
		profiles[player] = nil
	end)

	-- end
	return self
end

-- end
return Profile
