extends PlayerState

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
func _enter():
	super()
	char.sprite.animation_finished.connect(_on_sprite_animation_finished)
	char.sprite.self_modulate = Color(0,0,0,200)
	char.set_collision_layer_value(2,0)
	char.spend_stamina(char.DASH_STAMINA_COST)

func _update(delta: float) -> void:
	
	char.dir = -1 if char.sprite.flip_h else 1
	if char.dir:
		char.velocity.x = char.dir * SPEED
	char.move_and_slide()
	char._flip_sprite()
	
func _on_sprite_animation_finished():
	char.sprite.self_modulate = Color(1,1,1,1)
	char.set_collision_layer_value(2,1)
	dispatch("to_idle")
	
#endregion
