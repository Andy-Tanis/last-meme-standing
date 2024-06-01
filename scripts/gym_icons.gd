extends Node2D

@onready var move_component: MoveComponent = $MoveComponent
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready() -> void:
	
	visible_on_screen_notifier_2d.screen_exited.connect(func():
		await get_tree().create_timer(10.0).timeout
		queue_free()
	)
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var icon = rng.randi_range(1, 6)
	
	if icon == 1:
		$GigachadHead.show()
	elif icon == 2:
		$GigachadBarbell.show()
	elif icon == 3:
		$GigachadArmcurl.show()
	elif icon == 4:
		$KarenHead.show()
	elif icon == 5:
		$KarenCall.show()
	elif icon == 6:
		$KarenPolice.show()
	
	move_component.velocity.y = 350
	
func crush() -> void:
	
	if $".".position.y >= 450 and $".".position.y <= 600:
		if !$GigachadHead.is_visible_in_tree() and !$GigachadArmcurl.is_visible_in_tree() and !$GigachadBarbell.is_visible_in_tree():
			$Correct.play()
			$Explode.emitting = true
			get_tree().call_group("gigachad", "gigachad_progress_increase")
		else:
			$Incorrect.play()
			get_tree().call_group("gigachad", "gigachad_progress_decrease")
		$GigachadHead.hide()
		$GigachadArmcurl.hide()
		$GigachadBarbell.hide()
		$KarenHead.hide()
		$KarenPolice.hide()
		$KarenCall.hide()
		$GPUParticles2D.hide()
		
func speed_up() -> void:
	move_component.velocity.y *= 8
