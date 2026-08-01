extends characterState
class_name playerState

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var can_move : bool = false
@export var can_jump : bool = false
@export var can_dash : bool = false
@export var parry_state : LimboState = null
## Dictionary: Key = Attack Action State ----- values = mana cost (if any)
@export var attack_action : Dictionary[playerState, int] 
@export var charged_attack : LimboState 
#endregion

#region @ONREADY
#endregion

#region VARS
var player: playerClass
#endregion
#endregion

#region FUNCS
# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	super()
	player = agent as playerClass
	
func _update(delta : float) -> void:
	super(delta)
	if can_jump: _jump_logic()
	if can_dash: _dash_logic()
	if !attack_action.is_empty(): _attack_logic()
	if parry_state != null: _parry_logic()
	if charged_attack != null: _charged_attack_logic()

func take_damage(_dmg: int, _dmg_dir: int) -> void:
	super(_dmg, _dmg_dir)
	
func _on_sprite_animation_finished():
	pass

func _exit() -> void:
	super()

func _jump_logic():
	if Input.is_action_just_pressed("jump") and (player.is_on_floor() or !player.coyote_time_buffer.is_stopped()):
		player.velocity.y = player.JUMP_VELOCITY
		player.coyote_time_buffer.stop()
		dispatch("to_airborne")

func _parry_logic():
	if Input.is_action_just_pressed("parry"):
		dispatch("to_parry_action")

func _dash_logic():
	if Input.is_action_just_pressed("dash") and player.is_on_floor() and player.curr_stamina >= player.DASH_STAMINA_COST:
		dispatch("to_dash")

func _attack_logic():
	if Input.is_action_just_pressed("attack") and player.spend_mana(attack_action.values()[0]):
		dispatch("to_" + attack_action.keys()[0].name)

func _charged_attack_logic():
	if Input.is_action_just_pressed("charged_attack"):
		dispatch("to_" + charged_attack.name)

#endregion
