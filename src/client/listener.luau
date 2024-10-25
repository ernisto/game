local ReplicatedStorage = game:GetService('ReplicatedStorage')
local remotes = require(ReplicatedStorage.Client.Remotes)

remotes.example.MyFirstEvent.On(function() end)
