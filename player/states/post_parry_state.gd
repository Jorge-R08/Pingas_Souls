extends PlayerState
class_name postParryState

#TODO: Right now, parry/block is functionally an attack, maybe we should change this idk

#region DEFS
#region CONSTANTS
#endregion

#region @EXPORTS
@export var sparks_vfx : Node2D 
@export var sparks_x_offset : int = 42
@export var sparks_y_offset : int = -30
#endregion

#region @ONREADY
@onready var parry_reset_timer : Timer = %parry_reset_timer
#endregion

#region VARS
#endregion
var sparks_sprite : AnimatedSprite2D
var sparks_audio : AudioStreamPlayer2D
#endregion

#region FUNCS
# Called when the node enters the scene tree for the first time.
func _enter() -> void:
	super()
	sparks_sprite = sparks_vfx.get_children().filter(func(xd): return xd is AnimatedSprite2D)[0]
	sparks_audio = sparks_vfx.get_children().filter(func(xd): return xd is AudioStreamPlayer2D)[0]
	
	sparks_sprite.animation_finished.connect(_on_spark_animation_finished)
	parry_reset_timer.timeout.connect(_on_parry_reset_timer_timeout)
	parry_reset_timer.start()
	
	char.gain_mana(1)
	
	play_sparks_vfx("parry")

func _update(delta : float) -> void:
	super(delta)
	
func play_sparks_vfx(spark_type: String = "default"):
	sparks_vfx.global_position = char.global_position + Vector2(sparks_x_offset, sparks_y_offset)
	sparks_sprite.visible = true
	
	match spark_type:
		"parry":
			sparks_vfx.modulate = Color.ORANGE_RED
			sparks_vfx.scale = Vector2(1.5, 1.5) 
			sparks_audio.pitch_scale = 1.0
			sparks_audio.volume_db = -12.0
		"block":
			sparks_vfx.modulate = Color.YELLOW 
			sparks_vfx.scale = Vector2(1.0, 1.0) 
			sparks_audio.pitch_scale = 0.7
			sparks_audio.volume_db = -18.000
	sparks_sprite.play("default") 
	sparks_audio.play()
	

func _on_spark_animation_finished():
	sparks_sprite.visible = false

func _on_parry_reset_timer_timeout() -> void:
	dispatch("to_idle")

func _exit() -> void:
	super()
	parry_reset_timer.timeout.disconnect(_on_parry_reset_timer_timeout)
	sparks_sprite.animation_finished.disconnect(_on_spark_animation_finished)
	parry_reset_timer.stop()

#endregion
