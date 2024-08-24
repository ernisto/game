local ServerScriptService = game:GetService("ServerScriptService")
local assemble = require(ServerScriptService.Server.Match.Assembly.assemble)

return function()
    -- Teste 1: Bloco único em uma posição específica
    describe("Single Block", function()
        it("should return a single assembly for one block", function()
            local blocks = {
                [Vector3.new(0, 0, 0)] = { position = Vector3.new(0, 0, 0) }
            }
            local assemblies = assemble(blocks)

            expect(#assemblies).to.equal(1)
            expect(assemblies[1].blocks[Vector3.new(0, 0, 0)]).to.equal(blocks[Vector3.new(0, 0, 0)])
        end)
    end)

    -- Teste 2: Blocos conectados horizontalmente
    describe("Connected Horizontal Blocks", function()
        it("should group horizontally connected blocks into one assembly", function()
            local blocks = {
                [Vector3.new(0, 0, 0)] = { position = Vector3.new(0, 0, 0) },
                [Vector3.new(1, 0, 0)] = { position = Vector3.new(1, 0, 0) },
            }
            local assemblies = assemble(blocks)

            expect(#assemblies).to.equal(1)
            expect(assemblies[1].blocks).to.be.a("table")
            expect(assemblies[1].blocks).to.be.ok() -- Verifica se a tabela não é nula
            for pos, block in pairs(blocks) do
                expect(assemblies[1].blocks[pos]).to.equal(block)
            end
        end)
    end)

    -- Teste 3: Blocos empilhados verticalmente
    describe("Stacked Vertical Blocks", function()
        it("should group vertically stacked blocks into one assembly", function()
            local blocks = {
                [Vector3.new(0, 0, 0)] = { position = Vector3.new(0, 0, 0) },
                [Vector3.new(0, 1, 0)] = { position = Vector3.new(0, 1, 0) },
            }
            local assemblies = assemble(blocks)

            expect(#assemblies).to.equal(1)
            expect(assemblies[1].blocks).to.be.a("table")
            for pos, block in pairs(blocks) do
                expect(assemblies[1].blocks[pos]).to.equal(block)
            end
        end)
    end)

    -- Teste 4: Blocos desconectados
    describe("Disconnected Blocks", function()
        it("should create multiple assemblies for disconnected blocks", function()
            local blocks = {
                [Vector3.new(0, 0, 0)] = { position = Vector3.new(0, 0, 0) },
                [Vector3.new(10, 0, 0)] = { position = Vector3.new(10, 0, 0) },
            }
            local assemblies = assemble(blocks)

            expect(#assemblies).to.equal(2)
        end)
    end)

    -- Teste 5: Verificação de grounding
    describe("Grounding Check", function()
        it("should correctly detect when an assembly is grounded", function()
            local blocks = {
                [Vector3.new(0, 1, 0)] = { position = Vector3.new(0, 1, 0) },
                [Vector3.new(0, 0, 0)] = { position = Vector3.new(0, 0, 0) }, -- Este bloco está grounded
            }
            local assemblies = assemble(blocks)

            expect(#assemblies).to.equal(1)
            expect(assemblies[1].isGrounded).to.equal(true)
        end)
    end)
end
