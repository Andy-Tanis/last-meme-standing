extends Node2D

@onready var move_component: MoveComponent = $MoveComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var icon: int

func _ready() -> void:
	
	visible_on_screen_notifier_2d.screen_exited.connect(func():
		await get_tree().create_timer(10.0).timeout
		queue_free()
	)
	
	var rng = RandomNumberGenerator.new()
	move_component.velocity.y = rng.randi_range(50, 250)
	scale = [Vector2(.2, .2), Vector2(.4, .4), Vector2(.6, .6)].pick_random()
