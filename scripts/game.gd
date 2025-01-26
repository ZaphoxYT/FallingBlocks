extends Node2D

const BLOCK_SIZE = 32

@onready var grid:Grid = $Grid
@onready var spawn_point = grid.spawn_point
@onready var piece_selector: PieceSelector = $PieceSelector

var current_piece: Piece = null
var fall_timer: float = 0.0
var placing_timer: float = 0.0

func _ready():
	current_piece = grid.spawn_piece(piece_selector.next_piece.piece_name)
	piece_selector.select_next_piece()


func _process(delta):
	if current_piece:
		handle_inputs(delta)

		if grid.can_move(current_piece, Vector2.DOWN):
			current_piece.fall(delta)
		else:
			placing_timer += delta
			if placing_timer > Globals.TIME_TO_PLACE:
				grid.place_piece(current_piece)
				current_piece = null
				grid.clear_lines()
				current_piece = grid.spawn_piece(piece_selector.next_piece.piece_name)
				piece_selector.select_next_piece()
				placing_timer = 0.0

func handle_inputs(delta):
	if Input.is_action_just_pressed("ui_left") and grid.can_move(current_piece, Vector2.LEFT):
		current_piece.position.x -= BLOCK_SIZE

	if Input.is_action_just_pressed("ui_right") and grid.can_move(current_piece, Vector2.RIGHT):
		current_piece.position.x += BLOCK_SIZE

	if Input.is_action_just_pressed("rotate_piece"):
		current_piece.rotate_clockwise()
		if not grid.can_move(current_piece, Vector2.ZERO):
			# Try wall kicks
			var rotated = false
			#var kick_table = Piece.I_KICK_OFFSETS["clockwise"] if current_piece.my_shape == "I" else Piece.GENERAL_KICK_OFFSETS
#
			#for kick in kick_table:
				#if grid.can_move(current_piece, kick * BLOCK_SIZE):
					#current_piece.position += kick * BLOCK_SIZE
					#rotated = true
					#break

			if not rotated:
				# Undo rotation if no kick works
				current_piece.rotate_counterclockwise()


	if Input.is_action_pressed("ui_down"):
		Globals.falling_speed = 0.1

	if Input.is_action_just_released("ui_down"):
		Globals.falling_speed = 1.0
