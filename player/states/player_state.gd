extends CharacterState
class_name PlayerState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var can_move : bool = false
@export var can_jump : bool = false
@export var can_dash : bool = false
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion

#endregion

#region FUNCS
# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	super()
	char = agent as player
	char.sprite.animation_finished.connect(_on_sprite_animation_finished)


func _update(delta : float) -> void:
	super(delta)
	if can_jump: _jump_logic()
	if can_dash: _dash_logic()
	
func take_damage(_dmg: int, _dmg_dir: int) -> void:
	dispatch(&"to_hurt", {"dmg":_dmg,"dmg_dir":_dmg_dir})
	
func _on_sprite_animation_finished():
	pass
		
func _exit() -> void:
	char.sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	
func _jump_logic():
	if Input.is_action_just_pressed("jump") and (char.is_on_floor() or !char.coyote_time_buffer.is_stopped()):
		char.velocity.y = char.JUMP_VELOCITY
		char.coyote_time_buffer.stop()
		dispatch("to_airborne")
	
func _dash_logic():
	if Input.is_action_just_pressed("dash") and char.is_on_floor() and char.curr_stamina >= char.DASH_STAMINA_COST:
		dispatch("to_dash")
	
func _attack_logic():
	pass

#endregion
