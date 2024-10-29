local TestService = game:GetService('TestService')
local TestEZ = require(TestService.Packages.TestEZ) :: any

TestEZ.TestBootstrap:run({ TestService.Tests })
