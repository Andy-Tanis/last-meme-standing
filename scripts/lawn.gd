extends Node2D

var character = ["cloud", "karen"]

var game_over := false

var time_until_rotation := 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$ProgressBar.value = 50
	
	for n in $GridContainer.get_children():
		var character_to_use = [0, 1].pick_random()
		n.texture = load("res://assets/characters/" + character[character_to_use] + ".webp")
		
	$Boomer/AnimationPlayer.play("show")
	await get_tree().create_timer(.5).timeout
	$Karen/AnimationPlayer.play("show")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if time_until_rotation <= 0:
		rotate_items()
		time_until_rotation = 200
	elif !game_over:
		time_until_rotation -= 1
	
	if !game_over:
		
		if $ProgressBar.value < 100 and $ProgressBar.value > 0:
			
			$ProgressBar.value -= 0.05
				
		elif $ProgressBar.value == 100:
			
			win()
			
		elif $ProgressBar.value == 0:
			
			lose()


func _on_button_mow_1_pressed() -> void:
	
	lawnmower_spawned()
	
	$Lawnmower.position = Vector2(240, 290)
	
	$Lawnmower.show()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Lawnmower, "position", Vector2(2900, 290), 3.0)
	tween.tween_callback(finished_mowing)

func _on_button_mow_2_pressed() -> void:
	
	lawnmower_spawned()
	
	$Lawnmower.position = Vector2(240, 560)
	
	$Lawnmower.show()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Lawnmower, "position", Vector2(2900, 560), 3.0)
	tween.tween_callback(finished_mowing)
	
func _on_button_mow_3_pressed() -> void:
	
	lawnmower_spawned()
	
	$Lawnmower.position = Vector2(240, 820)
	
	$Lawnmower.show()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Lawnmower, "position", Vector2(2900, 820), 3.0)
	tween.tween_callback(finished_mowing)
	
func lawnmower_spawned() -> void:
	
	time_until_rotation = 200
	
	$AudioLawnmower.play()
	
	$ButtonMow1.hide()
	$ButtonMow2.hide()
	$ButtonMow3.hide()

func finished_mowing() -> void:
	
	time_until_rotation = 200
	
	rotate_items()
	
	if !game_over:
		$ButtonMow1.show()
		$ButtonMow2.show()
		$ButtonMow3.show()
		
	$Lawnmower.hide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("lawn_item"):
		if area.get_parent().get_texture().get_path().contains("cloud"):
			$Correct.play()
			area.get_parent().get_node("Label").text = "+10"
			$ProgressBar.value += 10
		elif area.get_parent().get_texture().get_path().contains("karen"):
			$Incorrect.play()
			area.get_parent().get_node("Label").text = "-10"
			$ProgressBar.value -= 10
			
		area.get_parent().get_node("Label").show()
			
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(area.get_parent(), "scale", Vector2(), 1)
		tween.tween_property(area.get_parent(), "modulate", Color(1,1,1,0), .5)
		tween.tween_callback(show_label.bind(area.get_parent().get_node("Label")))
		tween.tween_property(area.get_parent(), "scale", Vector2(1, 1), .5)
		tween.tween_property(area.get_parent(), "modulate", Color(1,1,1,1), 2)
		
		
func show_label(label_node) -> void:
	
	label_node.hide()

func rotate_items() -> void:
	
	for n in $GridContainer.get_children():
		var character_to_use = [0, 1].pick_random()
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(n, "modulate", Color(1,1,1,0), .1)
		tween.tween_property(n, "modulate", Color(1,1,1,1), 1)
		n.texture = load("res://assets/characters/" + character[character_to_use] + ".webp")
		
func win() -> void:
	
	game_over = true
	$Boomer/AnimationPlayer.play("win")
	$Karen/AnimationPlayer.play("lose")
	$LabelYouWinLose.text = "You Won!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Win.play()
	$GridContainer.hide()
	$ProgressBar.hide()
	
func lose() -> void:
	
	game_over = true
	$Karen/AnimationPlayer.play("win")
	$Boomer/AnimationPlayer.play("lose")
	$LabelYouWinLose.text = "You Lost!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Lose.play()
	$GridContainer.hide()
	$ProgressBar.hide()
