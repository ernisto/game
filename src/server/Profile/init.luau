-- packages
local ServerScriptService = game:GetService('ServerScriptService')
local ProfileStore = require(ServerScriptService.Packages.ProfileStore)

local template = require(script.template)
export type data = typeof(template)

export type Profile = ProfileStore.Profile<data>

-- module
local playersStore = ProfileStore.New('players', template)
local profiles = {}
local loadings = {}
local Profile = {}

-- functions
function Profile.isLoading(player: Player): boolean
	return loadings[player] or false
end
function Profile.find(player: Player): Profile?
	return profiles[player]
end
function Profile.expect(player: Player, errorMessage: string?): Profile
	return Profile.find(player) or error(errorMessage or `profile wasnt loaded`)
end
function Profile.awaitFind(player: Player): Profile?
	while loadings[player] do
		task.wait()
	end
	return loadings[player]
end
function Profile.awaitExpect(player: Player, errorMessage: string?): Profile
	return Profile.awaitFind(player) or error(errorMessage or `profile isnt loading/loaded`)
end

-- builder
function Profile.awaitCachedLoad(player: Player): Profile
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
