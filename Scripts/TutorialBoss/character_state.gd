class_name CharacterState
extends LimboState

@export var animation_name: StringName

var mob: Boss1

func _enter() -> void:
	mob = agent as Boss1
	
	print("entered state: ", name)

	if mob == null:
		push_error("Agent is not Mob")
		return

	if animation_name != "":
		print(animation_name)
		mob.sprite.play(animation_name)
