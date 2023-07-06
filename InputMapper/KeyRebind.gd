extends Control

@onready var selectPopup = $CenterContainer/KeySelectPopup
@onready var buttonHolder = $VBoxContainer/ButtonHolder
@onready var inputMapper = $InputMapper


func _ready():
	for action in KeyActions.actions.keys():
		var button = buttonHolder.add_button(action, KeyActions.actions[action])
		button.pressed.connect(_on_rebind_button_pressed.bind(button))
		if !InputMap.has_action(action):
			InputMap.add_action(action)


func _on_rebind_button_pressed(button):
	set_process_input(false)
	
	selectPopup.open()
	var keycode = await selectPopup.key_selected
	inputMapper.change_action_key(button.get_meta("action")[0], keycode)
	buttonHolder.update_button(button, keycode)
	
	set_process_input(true)


func _on_done_button_pressed() -> void:
	get_tree().reload_current_scene()
