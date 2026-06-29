extends LimboState
class_name CharacterState

@export var animation_name: StringName

var char: baseChar

func _enter() -> void:
	char = agent as baseChar
	
	print("entered state: ", name)

	if char == null:
		push_error("Agent is not Character")
		return

	if animation_name != "":
		char.sprite.play(animation_name)

	char = agent as baseChar
	_setup_exports()
	_state_specific_enter()
	char._flip_sprite()
	
	
#to be overwritte if needed
func _setup_exports():
	pass
	
func _state_specific_enter():
	push_error("WARNING STATE DID NOT OVERRIDE THE _state_specific_enter() FUNCTION")
