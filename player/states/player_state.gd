extends CharacterState
class_name PlayerState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var can_move : bool = false
@export var can_jump : bool = false
@export var can_dash : bool = false
@export var parry_state : LimboState = null
@export var attack_action : Dictionary[PlayerState, int] 
@export var charged_attack : LimboState 
@export var debug_black_effect : bool = false
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
	if debug_black_effect: char.sprite.self_modulate = Color(0,0,0,200)

func _update(delta : float) -> void:
	super(delta)
	if can_jump: _jump_logic()
	if can_dash: _dash_logic()
	if !attack_action.is_empty(): _attack_logic()
	if parry_state != null: _parry_logic()
	if charged_attack != null: _charged_attack_logic()

func take_damage(_dmg: int, _dmg_dir: int) -> void:
	dispatch(&"to_hurt", {"dmg":_dmg,"dmg_dir":_dmg_dir})
	
func _on_sprite_animation_finished():
	pass

func _exit() -> void:
	char.sprite.animation_finished.disconnect(_on_sprite_animation_finished)
	if debug_black_effect: char.sprite.self_modulate = Color(1,1,1,1)

func _jump_logic():
	if Input.is_action_just_pressed("jump") and (char.is_on_floor() or !char.coyote_time_buffer.is_stopped()):
		char.velocity.y = char.JUMP_VELOCITY
		char.coyote_time_buffer.stop()
		dispatch("to_airborne")

func _parry_logic():
	if Input.is_action_just_pressed("parry"):
		dispatch("to_parry_action")

func _dash_logic():
	if Input.is_action_just_pressed("dash") and char.is_on_floor() and char.curr_stamina >= char.DASH_STAMINA_COST:
		dispatch("to_dash")

func _attack_logic():
	if Input.is_action_just_pressed("attack") and char.spend_mana(attack_action.values()[0]):
		dispatch("to_" + attack_action.keys()[0].name)

func _charged_attack_logic():
	if Input.is_action_just_pressed("charged_attack"):
		dispatch("to_" + charged_attack.name)

#endregion
