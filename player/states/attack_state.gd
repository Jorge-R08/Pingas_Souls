extends CharacterState

#region DEFS
#region CONSTANTS
const STOP_SPEED : int = 10
#endregion

#region @EXPORTS
@export var damage : int
@export var next_attack : CharacterState = null
@export var combo_reset_timer : Timer
@export var DIR_LOCKOUT_FRAME : int
@export var SPEED : int = 100
@export var hitzone : Area2D
#endregion

#region @ONREADY
#endregion

#region VARS
var post_attack : bool = false
#endregion
#endregion

func _enter():
	super()
	post_attack = false
	char.sprite.animation_finished.connect(_on_sprite_animation_finished)
	combo_reset_timer.timeout.connect(_on_combo_reset_timer_timeout)
	combo_reset_timer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	if Input.is_action_just_pressed("attack") and (next_attack != null) and !combo_reset_timer.is_stopped():
		print(next_attack.name)
		dispatch("to_" + next_attack.name)

	if char.sprite.frame < DIR_LOCKOUT_FRAME or post_attack:
		char.dir = Input.get_axis("left", "right")
		
		if char.dir:
			char.velocity.x = char.dir * SPEED
		else:
			char.velocity.x = move_toward(char.velocity.x, 0, 300)
		
		char._flip_sprite()
		char.move_and_slide()
	
func _on_sprite_animation_finished():
	post_attack = true
	if next_attack:
		combo_reset_timer.start()
	else:
		dispatch("to_idle")

func _on_combo_reset_timer_timeout() -> void:
	dispatch("to_idle")

func _exit() -> void:
	char.sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	combo_reset_timer.timeout.disconnect(_on_combo_reset_timer_timeout)
	
