extends Control

# Added new signals for bttons to load whatever image is attatched to it
# Loads correspondiong images with the bttons
# New learning: ResourceLoader
# New learning: Global: load without erasing scene (autoload)

func _on_forest_btn_pressed() -> void:
	Global.selected_theme = "forest"
	get_tree().change_scene_to_file("res://scenes/Root.tscn")


func _on_valley_btn_pressed() -> void:
	Global.selected_theme = "valley"
	get_tree().change_scene_to_file("res://scenes/Root.tscn")


func _on_montain_btn_pressed() -> void:
	Global.selected_theme = "mountains"
	get_tree().change_scene_to_file("res://scenes/Root.tscn")
