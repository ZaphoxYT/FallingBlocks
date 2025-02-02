extends Control

func _release_all_focus() -> void:
	get_tree().call_group("Buttons", "release_focus")

func _on_debug_mode_toggled(toggled_on: bool) -> void:
	Globals.is_debug_mode_on = toggled_on
	_release_all_focus()


func _on_i_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.debug_shapes.append('I')
	else:
		Globals.debug_shapes.erase('I')
	_release_all_focus()

func _on_o_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.debug_shapes.append('O')
	else:
		Globals.debug_shapes.erase('O')
	_release_all_focus()

func _on_t_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.debug_shapes.append('T')
	else:
		Globals.debug_shapes.erase('T')
	_release_all_focus()

func _on_l_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.debug_shapes.append('L')
	else:
		Globals.debug_shapes.erase('L')
	_release_all_focus()

func _on_j_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.debug_shapes.append('J')
	else:
		Globals.debug_shapes.erase('J')
	_release_all_focus()

func _on_s_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.debug_shapes.append('S')
	else:
		Globals.debug_shapes.erase('S')
	_release_all_focus()

func _on_z_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Globals.debug_shapes.append('Z')
	else:
		Globals.debug_shapes.erase('Z')
	_release_all_focus()
