extends Node

func change_action_key(action_name: StringName, keycode):
	remove_action_events(action_name)
	
	var event = InputEventKey.new()
	event.keycode = keycode
	KeyActions.actions[action_name] = keycode
	InputMap.action_add_event(action_name, event)
	
	
func remove_action_events(action_name: StringName):
	for event in InputMap.action_get_events(action_name):
		InputMap.action_erase_event(action_name, event)
