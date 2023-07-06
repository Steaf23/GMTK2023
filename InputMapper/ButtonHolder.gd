extends GridContainer


func add_button(action, keycode):
	var button = Button.new()
	add_child(button)
	button.set_meta("action", [action, keycode])
	update_button(button, keycode)
	return button


func update_button(button, keycode):
	var key_string = PackedByteArray([keycode]).get_string_from_utf8()
	if key_string == " ":
		key_string = "SPACE"
	button.text = "%s: [%s]" % [button.get_meta("action")[0], key_string]
	button.set_meta("action", [button.get_meta("action")[0], keycode])
