extends Node

const GRID_WIDTH = 10
const GRID_HEIGHT = 20
const BLOCK_SIZE = 32
const TIME_TO_PLACE = 1.0

var falling_speed = 1.0

var debug_shapes: Array[String] = []
var is_debug_mode_on: bool = false :
	set = toggle_debug_mode

func toggle_debug_mode(_is_debug_mode_on:bool) -> void:
	is_debug_mode_on = _is_debug_mode_on
