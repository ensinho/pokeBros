extends CanvasLayer

func _ready() -> void:
	$menuTheme.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
