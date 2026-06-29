extends LimboState

# maybe change this to be 2 function calls: A "generic entes" that will be shared by all child classes,
# and then a "specific enter" that is just the custom functioanlity
func _enter() -> void:
	_setup_exports()
	print("ENTERING IDLE STATE")
	agent._flip_sprite()

func _update(delta : float) -> void:
	pass

func _setup_exports():
	#agent.speed = SPEED
	pass
