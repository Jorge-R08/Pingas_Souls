extends PlayerState

#TODO: Right now, parry/block is functionally an attack, maybe we should change this idk

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
@export var block_frames : int = -1
@export var hit_frame : int
@export var charged : bool = false
#endregion

#region @ONREADY
@onready var combo_reset_timer : Timer = %combo_reset_timer
#endregion

#region VARS
var post_attack : bool = false
var charge_complete : bool = false
#endregion
#endregion

func _enter():
	super()
	post_attack = false
	charge_complete = false
	combo_reset_timer.timeout.connect(_on_combo_reset_timer_timeout)
	combo_reset_timer.stop()
	if charged: 
		char.sprite.frame_changed.connect(_on_frame_changed)
		char.sprite.sprite_frames.set_frame("down_swing", 2, char.sprite.sprite_frames.get_frame_texture("down_swing", 2), 2.0)
		char.sprite.sprite_frames.set_frame("down_swing", 1, char.sprite.sprite_frames.get_frame_texture("down_swing", 1), 2.0)
	
	if hitzone != null: hitzone.monitoring = true

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

	if char.sprite.frame == hit_frame and hitzone != null:
		if hitzone.has_overlapping_bodies():
			hitzone.monitoring = false
			char.boss_target.health = max(char.boss_target.health - damage, 0)
	
	if !Input.is_action_pressed("charged_attack"):
		if charge_complete:
			charge_complete = false
			char.sprite.frame_changed.disconnect(_on_frame_changed)
			char.sprite.frame = 3

func _on_sprite_animation_finished():
	post_attack = true
	if next_attack:
		combo_reset_timer.start()
	else:
		dispatch("to_idle")

func _on_combo_reset_timer_timeout() -> void:
	dispatch("to_idle")
	
func _on_frame_changed() -> void:
	if char.sprite.frame == 3 and Input.is_action_pressed("charged_attack"):
		char.sprite.frame = 1
		charge_complete = true
	elif char.sprite.frame == 3:
		dispatch("to_idle")

func _exit() -> void:
	super()
	combo_reset_timer.stop()
	combo_reset_timer.timeout.disconnect(_on_combo_reset_timer_timeout)
	char.sprite.frame_changed.disconnect(_on_frame_changed)
	char.sprite.sprite_frames.set_frame("down_swing", 2, char.sprite.sprite_frames.get_frame_texture("down_swing", 2), 1.0)
	char.sprite.sprite_frames.set_frame("down_swing", 1, char.sprite.sprite_frames.get_frame_texture("down_swing", 1), 1.0)
	

func take_damage(_dmg, _dir):
	if parry_frames != -1 and char.sprite.frame <= parry_frames:
		dispatch("to_parry")
	elif block_frames != -1 and char.sprite.frame <= block_frames:
		super(_dmg/2, _dir)
		print("attack blocked jijijuju")
		#TODO: there should be an event handler for the "to_parry" transition
		# to do different behavior based on if it is a parry or block, see hurt_state
	else:
		super(_dmg, _dir)
