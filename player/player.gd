extends baseChar

#TODO:
# fix the sprite moving when flip_h is changed because of the offset in the sprite itself

#region CONSTANTS
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion


func _char_ready():
	print("PLAYER READY")

func _physics_process(delta: float) -> void:
	pass
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#dir = Input.get_axis("left", "right")
	#if dir:
		#hsm.dispatch("to_running")
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	#_flip_sprite()
