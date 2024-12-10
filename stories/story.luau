local TestService = game:GetService('TestService')
local uilabs = require(TestService.Packages.uilabs)

local function story<Controls>(controls: Controls, test: (target: Instance, controls: Controls) -> (() -> ())?)
	return {
		controls = controls,
		render = function(env)
			local target = env.target
			local destroy: () -> ()?, thread

			local function update(props)
				if thread then task.cancel(thread) end
				if destroy then destroy() end

				destroy = nil
				thread = task.spawn(function()
					destroy = test(target, props)
				end)
			end

			update(env.controls)
			env.subscribe(function(newProps)
				update(newProps)
			end)

			return function()
				if thread then task.cancel(thread) end
				if destroy then destroy() end
			end
		end,
	}
end

return table.freeze {
	story = story,

	Boolean = (uilabs.Boolean :: any) :: (default: boolean) -> boolean,
	Number = (
			uilabs.Number :: any
		) :: (default: number, min: number?, max: number?, step: number?, dragger: boolean?, sens: number?) -> number,
	String = (
			uilabs.String :: any
		) :: (default: string, filters: { (input: string, oldInput: string) -> string }?) -> string,

	Choose = (uilabs.Choose :: any) :: <T>(options: { T }, defaultIndex: number?) -> T,
	EnumList = (uilabs.EnumList :: any) :: <T, K>(options: { [K]: T }, defaultKey: K) -> T,
	-- :: <Options>(options: Options, defaultKey: keyof<Options>) -> valueof<Options>,
	Object = (
			uilabs.Object :: any
		) :: (className: string?, default: Instance?, predicator: ((instance: Instance) -> boolean)?) -> Instance?,
	RGBA = (uilabs.RGBA :: any) :: (default: Color3, transparency: number?) -> { Color: Color3, Transparency: number },
	Slider = (uilabs.Slider :: any) :: (default: number, min: number, max: number, step: number?) -> number,

	ControlGroup = uilabs.ControlGroup,
	Ordered = uilabs.Ordered,
}
