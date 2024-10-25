local ReplicatedStorage = game:GetService('ReplicatedStorage')
local inventory = require(ReplicatedStorage.Remotes.inventory.server)

inventory.MyFirstEvent.FireAll('cavalo')
