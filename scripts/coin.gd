extends Node2D

@onready var move_component: MoveComponent = $MoveComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var icon: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	visible_on_screen_notifier_2d.screen_exited.connect(func():
		await get_tree().create_timer(10.0).timeout
		queue_free()
	)
	
	#get_tree().root.connect("game_over_signal", speed_up)
	
	icon = [1, 2].pick_random()
	
	if icon == 1:
		$CoinBackground/Cloud.show()
	elif icon == 2:
		$CoinBackground/Karen.show()
	
	var rng = RandomNumberGenerator.new()
	move_component.velocity.y = rng.randi_range(-50, -250)
	scale = [Vector2(.2, .2), Vector2(.4, .4), Vector2(.6, .6), Vector2(.8, .8)].pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	
	if icon == 1:
		$Correct.play()
	elif icon == 2:
		$Incorrect.play()
	
	$GPUParticles2D.hide()
	$Explode.emitting = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property($CoinBackground, "scale", Vector2(), 1)
	tween.tween_callback(queue_free)

func speed_up() -> void:
	move_component.velocity.y *= 2
	print("hello world")
