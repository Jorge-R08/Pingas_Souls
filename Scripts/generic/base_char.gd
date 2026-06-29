extends CharacterBody2D
class_name baseChar

#region @EXPORTS
@export var sprite : AnimatedSprite2D
@export var facing_right : bool = false
#endregion

#region @ONREADY
@onready var hsm: LimboHSM = $HSM
#endregion

#region VARS
var dir : int = 0
#endregion

func _char_ready():
	print("WARNING MOB DID NOT OVERRIDE THE _mob_ready() FUNCTION")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_base_char_ready()
	_char_ready()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _flip_sprite():
	if dir == 1:
		sprite.flip_h = false
	elif dir == -1:
		sprite.flip_h = true
		
func _base_char_ready():
	sprite.flip_h = true if !facing_right else false
	
	
