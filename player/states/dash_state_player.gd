extends playerState

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
	player.set_collision_layer_value(2,0)
	player.spend_stamina(player.DASH_STAMINA_COST)
	if debug_black_effect: player.sprite.self_modulate = Color(0,0,0,200)

func _update(delta: float) -> void:
	super(delta)
	player.dir = player.transform.x.x
	player.velocity.x = player.dir * SPEED

	player.move_and_slide()
	player._flip_sprite()

func _on_sprite_animation_finished():
	dispatch("to_idle")

func _exit() -> void:
	super()
	player.set_collision_layer_value(2,1)
	if debug_black_effect: player.sprite.self_modulate = Color(1,1,1,1)

#endregion
