extends CharacterState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var SPEED : int = 600
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

#region FUNCS
func _state_specific_enter() -> void:
	char.sprite.animation_finished.connect(_on_sprite_animation_finished)
	char.sprite.self_modulate = Color(0,0,0,200)

func _update(delta: float) -> void:
	
	char.dir = -1 if char.sprite.flip_h else 1
	if char.dir:
		char.velocity.x = char.dir * SPEED
	char.move_and_slide()
	char._flip_sprite()
	
func _on_sprite_animation_finished():
	char.sprite.self_modulate = Color(1,1,1,1)
	dispatch("to_idle")
	
#endregion
