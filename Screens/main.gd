extends Node2D

var anim: AnimatedSprite2D
var rdm

func _ready():
	anim = get_node("Background/Logo")
	rdm = RandomNumberGenerator.new()

func _on_timer_timeout():
	get_node("Background/Logo/Timer").wait_time = rdm.randf_range(10, 20)
	anim.play("default")


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Screens/saves-screen.tscn")


func _on_settings_pressed():
	pass # Replace with function body.


func _on_credits_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
