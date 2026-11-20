extends Node
class_name animationStep

#region DEFS
#region CONSTANTS
enum step_type {ANIMATION, MOVEMENT, WAIT}
#endregion

#region @EXPORTS
#endregion

#region @ONREADY
#endregion

#region VARS
@export var type : step_type
@export var args : Array
#endregion
#endregion

#region FUNCS
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	super(delta)

#endregion
