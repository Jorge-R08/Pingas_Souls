extends CharacterBody2D
class_name baseChar

#region DEFS

#region CONSTANTS
const MAX_HEALTH : int = 100
#endregion

#region @EXPORTS
@export var sprite : AnimatedSprite2D
@export var facing_right : bool = false
@export var hitzones : Node2D
@export var debug : bool = true
#endregion

#region @ONREADY
#endregion

#region VARS
var dir : int = 0
var curr_health : int = MAX_HEALTH
#endregion
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dir = 1 if facing_right else -1
	_flip_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _flip_sprite():
	if dir != 0:
		transform.x.x = dir
	
func take_damage(_dmg: int, _dmg_direction: int) -> void:
	curr_health = max(0, curr_health - _dmg)
