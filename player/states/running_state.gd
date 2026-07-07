extends PlayerState

#region DEFS
#region CONSTANTS
const JUMP_VELOCITY = -400.0
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
	
func _update(delta : float) -> void:
	char.dir = Input.get_axis("left", "right")
	if char.dir:
		char.velocity.x = char.dir * SPEED
	else:
		dispatch("to_idle")
		
	if Input.is_action_just_pressed("attack"):
		dispatch("to_combo1_state")
	elif Input.is_action_just_pressed("jump") and char.is_on_floor():
		char.velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("dash") and char.is_on_floor() and char.curr_stamina > char.DASH_STAMINA_COST:
		dispatch("to_dash")
		
	if !char.is_on_floor():
		dispatch("to_airborne")
		
	char.move_and_slide()
	char._flip_sprite()

func _setup_exports():
	pass
