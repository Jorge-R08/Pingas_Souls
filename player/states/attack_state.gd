extends PlayerState

#region DEFS
#region CONSTANTS
const STOP_SPEED : int = 10
#endregion

#region @EXPORTS
@export var damage : int
@export var next_attack : CharacterState = null
@export var DIR_LOCKOUT_FRAME : int
@export var SPEED : int = 100
@export var hitzone : Area2D
## the last parry frame of the animation
@export var parry_frames : int = -1
@export var hit_frame : int
#endregion

#region @ONREADY
@onready var combo_reset_timer : Timer = %combo_reset_timer
#endregion

#region VARS
var post_attack : bool = false
#endregion
#endregion

func _enter():
	super()
	post_attack = false
	combo_reset_timer.timeout.connect(_on_combo_reset_timer_timeout)
	combo_reset_timer.stop()
	
	hitzone.monitoring = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _update(delta: float) -> void:
	super(delta)
	if Input.is_action_just_pressed("attack") and (next_attack != null) and !combo_reset_timer.is_stopped():
		dispatch("to_" + next_attack.name)

	if char.sprite.frame < DIR_LOCKOUT_FRAME or post_attack:
		char.dir = Input.get_axis("left", "right")
		
		if char.dir:
			char.velocity.x = char.dir * SPEED
		else:
			char.velocity.x = move_toward(char.velocity.x, 0, 300)

		char._flip_sprite()
		char.move_and_slide()

	if char.sprite.frame == hit_frame:
		if hitzone.has_overlapping_bodies():
			hitzone.monitoring = false
			char.boss_target.health = 50
	
func _on_sprite_animation_finished():
	post_attack = true
	if next_attack:
		combo_reset_timer.start()
	else:
		dispatch("to_idle")

func _on_combo_reset_timer_timeout() -> void:
	dispatch("to_idle")

func _exit() -> void:
	super()
	combo_reset_timer.stop()
	combo_reset_timer.timeout.disconnect(_on_combo_reset_timer_timeout)
	
func take_damage(_dmg, _dir):
	if parry_frames != -1 and char.sprite.frame <= parry_frames:
		dispatch("to_parry")
	else:
		super(_dmg, _dir)
