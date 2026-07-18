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
	char.set_collision_layer_value(2,0)
	char.spend_stamina(char.DASH_STAMINA_COST)
	if debug_black_effect: char.sprite.self_modulate = Color(0,0,0,200)

func _update(delta: float) -> void:
	super(delta)
	char.dir = char.transform.x.x
	char.velocity.x = char.dir * SPEED

	char.move_and_slide()
	char._flip_sprite()

func _on_sprite_animation_finished():
	dispatch("to_idle")

func _exit() -> void:
	super()
	char.set_collision_layer_value(2,1)
	if debug_black_effect: char.sprite.self_modulate = Color(1,1,1,1)

#endregion
