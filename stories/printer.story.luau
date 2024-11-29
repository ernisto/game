local story = require(game.ServerStorage.Stories.story)

return story.story({
	message = 'default message',
}, function(target, props)
	print(props.message)
	return
end)
