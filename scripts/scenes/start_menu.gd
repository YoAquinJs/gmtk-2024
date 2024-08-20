class_name StartMenu extends Scene


func _on_start_button_pressed() -> void:
    Singletons.game_manager.start_introduction()
