extends PlayerState

#region DEFS
#region CONSTANTS
const STOP_SPEED : int = 10
#endregion

#region @EXPORTS
@export var SPEED : int = 300
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

func _enter():
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	super(delta)
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	else:
		dispatch("to_idle")
	
	player.dir = Input.get_axis("left", "right")
	if player.dir:
		player.velocity.x = player.dir * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, STOP_SPEED)
	
	player.move_and_slide()
	player._flip_sprite()
