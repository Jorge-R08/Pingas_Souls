@tool
extends baseBoss

#region DEFS
#region CONSTANTS
#endregion



#region @EXPORTS
## First element is one of [animation, movement, wait][br]
## Then follow that step's arguments:[br]
## animation: String with the name of the sprite's animation[br]
## movement: Same as in set_position_relative()[br]
## wait: Int with how long to wait for
@export var animation_sequence : Array[Array]
#endregion

#region @ONREADY
#endregion

#region VARS
#endregion
#endregion

#region FUNCS
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	super()

func _process(delta: float) -> void:
	#super()
	pass
	
func set_position_relative(delta_vector : Vector2, duration : float, tween_ease, tween_trans) -> void:
	match tween_ease:
		"in":
			tween_ease = Tween.EASE_IN
		"out":
			tween_ease = Tween.EASE_OUT
		"in_out":
			tween_ease = Tween.EASE_IN_OUT
		"out_in":
			tween_ease = Tween.EASE_OUT_IN
		_:
			print("ERROR, INVALID TWEEN_EASE VALUE")
	match tween_trans:
		"linear":
			tween_trans = Tween.TRANS_LINEAR
		"sine":
			tween_trans = Tween.TRANS_SINE
		"quint":
			tween_trans = Tween.TRANS_QUINT
		"quart":
			tween_trans = Tween.TRANS_QUART
		"quad":
			tween_trans = Tween.TRANS_QUAD
		"expo":
			tween_trans = Tween.TRANS_EXPO
		"elastic":
			tween_trans = Tween.TRANS_ELASTIC
		"cubic":
			tween_trans = Tween.TRANS_CUBIC
		"circ":
			tween_trans = Tween.TRANS_CIRC
		"bounce":
			tween_trans = Tween.TRANS_BOUNCE
		"back":
			tween_trans = Tween.TRANS_BACK
		"spring":
			tween_trans = Tween.TRANS_SPRING
		_:
			print("ERROR, INVALID TWEEN_TRANS VALUE")
			
	print("penepene")
	var tween = create_tween()
	tween.tween_property(self, "position", position + (delta_vector*dir), duration)\
		.set_ease(tween_ease)\
		.set_trans(tween_trans)

@export_tool_button("Play Animation", "Play") 
var play_animation = func(): test()

func test():
	for step in animation_sequence:
		match step[0]:
			"animation":
				sprite.play(step[1])
			"movement":
				set_position_relative(step[1], step[2], step[3], step[4])
			"wait":
				await get_tree().create_timer(step[1]).timeout
			_:
				printerr("ERROR: INVALID ARGUMENTS FOR ANIMATION TEST SEQUENCE")


	#sprite.play(test_animation)
	#await get_tree().create_timer(0.5).timeout
	#set_position_relative(Vector2(-200,0), 1, Tween.EASE_OUT, Tween.TRANS_CUBIC)

#endregion
