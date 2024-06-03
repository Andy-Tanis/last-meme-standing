extends Node2D

@onready var move_component: MoveComponent = $MoveComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var icon: int

func _ready() -> void:
	
	visible_on_screen_notifier_2d.screen_exited.connect(func():
		await get_tree().create_timer(10.0).timeout
		queue_free()
	)
	
	icon = [0, 1, 2, 3, 4, 5].pick_random()
	
	if icon == 0:
		$CoinBackground/Cloud.show()
	elif icon == 1:
		$CoinBackground/Karen.show()
	elif icon == 2:
		$CoinBackground/KarenCall.show()
	elif icon == 3:
		$CoinBackground/KarenPolice.show()
	elif icon == 4:
		$CoinBackground/Lawnmower.show()
	elif icon == 5:
		$CoinBackground/BoomerHead.show()
	
	var rng = RandomNumberGenerator.new()
	move_component.velocity.y = rng.randi_range(-50, -250)
	scale = [Vector2(.1, .1), Vector2(.2, .2), Vector2(.4, .4), Vector2(.6, .6), Vector2(.8, .8)].pick_random()

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	
	$Button.hide()
	
	if icon == 0 or icon == 4 or icon == 5:
		$Correct.play()
	elif icon == 1 or icon == 2 or icon == 3:
		$Incorrect.play()
	
	$GPUParticles2D.hide()
	$Explode.emitting = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property($CoinBackground, "scale", Vector2(), 1)
	tween.tween_callback(queue_free)

func speed_up() -> void:
	move_component.velocity.y *= 8
