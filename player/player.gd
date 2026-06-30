extends baseChar

#TODO:
# fix the sprite moving when flip_h is changed because of the offset in the sprite itself

#region DEFS
#region CONSTANTS
const MAX_HEALTH : int = 100
const MAX_STAMINA : int = 100
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
@onready var body_hitbox: CollisionShape2D = $body_hitbox
#endregion

#region VARS
#endregion
#endregion

func _char_ready():
	print("PLAYER READY")
	

func _physics_process(delta: float) -> void:
	pass
	
