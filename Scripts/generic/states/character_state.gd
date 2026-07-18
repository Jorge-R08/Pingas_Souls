extends LimboState
class_name CharacterState

@export var animation_name: StringName

var char: baseChar

func _enter() -> void:
	char = agent as baseChar

	if char == null:
		push_error("Agent is not Character")
		return

	if animation_name != "" and animation_name != char.sprite.animation:
		char.sprite.play(animation_name)

	if char.debug:
		print("entered state: ", name)

	char._flip_sprite()
	
func _update(delta: float) -> void:
	pass
