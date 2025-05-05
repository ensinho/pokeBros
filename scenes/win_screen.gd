extends CanvasLayer

func _ready() -> void:
	$WinSound.play()

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_voltar_ao_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menuHome.tscn")
