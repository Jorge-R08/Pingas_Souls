class_name Teleport
extends CharacterState

@export var teleport_distance: float = 550.0
const fixed_y: float = -624.0

func _enter() -> void:
	super()

	mob.sprite.visible = false

	await get_tree().create_timer(0.3).timeout

	var side: float = sign(mob.global_position.x - mob.target.global_position.x)

	if side == 0:
		side = 1

	var new_x: float = mob.target.global_position.x + side * teleport_distance
	mob.global_position = Vector2(new_x, fixed_y)

	await get_tree().create_timer(0.2).timeout

	mob.sprite.visible = true
