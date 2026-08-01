extends LimboState
class_name characterState

@export var animation_name: StringName
@export var debug_black_effect : bool = false

var character: baseChar

func _enter() -> void:
	character = agent as baseChar

	if character == null:
		push_error("Agent is not Character")
		return

	if animation_name != "":
		if character.animation_player.has_animation(animation_name) and animation_name != character.animation_player.current_animation:
			character.animation_player.play(animation_name)
		elif animation_name != character.sprite.animation:
			character.sprite.play(animation_name)

	if character.debug:
		print("CHARACTER: ", character.name, " --- ", "entered state: ", name)

	character._flip_sprite()
	
	if debug_black_effect: character.sprite.self_modulate = Color(0,0,0,200)
	character.sprite.animation_finished.connect(_on_sprite_animation_finished)

	
func _update(delta: float) -> void:
	pass
	
func _exit() -> void:
	if debug_black_effect: character.sprite.self_modulate = Color(1,1,1,1)
	character.sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	
func take_damage(_dmg: int, _dmg_dir: int) -> void:
	dispatch(&"to_hurt", {"dmg":_dmg,"dmg_dir":_dmg_dir})
	
func _on_sprite_animation_finished():
	pass
