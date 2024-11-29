local story = require(game.ServerStorage.Stories.story)

return story.story({
	message = 'default message',
}, function(target, props)
	warn(`printer loaded!`)
	print(props.message)
	return function()
		warn(`printer unloaded`)
	end
end)
