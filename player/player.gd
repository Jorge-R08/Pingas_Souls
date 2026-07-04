extends baseChar
class_name player

#region DEFS
#region CONSTANTS
const MAX_STAMINA : int = 100
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
@onready var body_hitbox: CollisionShape2D = $body_hitbox
#endregion

#region VARS
var curr_stamina : int = MAX_STAMINA
#endregion

#endregion

func _ready():
	super()
	hsm.add_event_handler(&"to_hurt", $HSM/hurt_state._on_hurt_enter)
	print("PLAYER READY")

func _process(delta : float) -> void:
	super(delta)

func take_damage(_dmg: int, _dmg_direction: int) -> void:
	super(_dmg, _dmg_direction)
	hsm.dispatch(&"to_hurt", {"dmg":_dmg,"dmg_dir":_dmg_direction})
