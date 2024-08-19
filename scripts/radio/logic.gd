extends Control


func _ready() -> void:
    Singletons.dialog_system.dequeued_dialog.connect(_on_dequeued_dialog)

    match Singletons.game_manager.stage:
        GameManager.Stage.CITIZEN:
            citizen_report()
        GameManager.Stage.HAND:
            hand_report()

func citizen_report() -> void:
    for new in Singletons.game_manager.get_citizen_report():
        Singletons.dialog_system.enqueue_dialog(DialogSystem.Dialog.new(new, true))

func hand_report() -> void:
    for stat_change in Singletons.game_manager.get_hand_report():
        Singletons.dialog_system.enqueue_dialog(DialogSystem.Dialog.new(stat_change, true))

func _on_dequeued_dialog() -> void:
    Singletons.game_manager.end_radio_transition()
