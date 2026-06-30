class_name Teleport
extends BossState

@export var teleport_distance: float = 550.0
const FIXED_Y: float = -624.0

var tutorial_boss: TutorialBoss

func _enter() -> void:
	super()
	tutorial_boss = boss as TutorialBoss

	tutorial_boss.sprite.visible = false

	await get_tree().create_timer(0.3).timeout

	var side: float = sign(boss.global_position.x - tutorial_boss.target.global_position.x)

	if side == 0:
		side = 1

	var new_x: float = tutorial_boss.target.global_position.x + side * teleport_distance
	tutorial_boss.global_position = Vector2(new_x, FIXED_Y)

	await get_tree().create_timer(0.2).timeout

	tutorial_boss.sprite.visible = true
	dispatch(&"move")
