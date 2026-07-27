extends LimboState
class_name CharacterState

@export var animation_name: StringName
@export var debug_black_effect : bool = false

@warning_ignore("shadowed_global_identifier")
var char: baseChar

func _enter() -> void:
	char = agent as baseChar

	if char == null:
		push_error("Agent is not Character")
		return

	if animation_name != "" and animation_name != char.sprite.animation:
		char.sprite.play(animation_name)

	if char.debug:
		print("CHARACTER: ", char.name, " --- ", "entered state: ", name)

	char._flip_sprite()
	
	if debug_black_effect: char.sprite.self_modulate = Color(0,0,0,200)
	char.sprite.animation_finished.connect(_on_sprite_animation_finished)

	
func _update(delta: float) -> void:
	pass
	
func _exit() -> void:
	if debug_black_effect: char.sprite.self_modulate = Color(1,1,1,1)
	char.sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	
func take_damage(_dmg: int, _dmg_dir: int) -> void:
	dispatch(&"to_hurt", {"dmg":_dmg,"dmg_dir":_dmg_dir})
	
func _on_sprite_animation_finished():
	pass
