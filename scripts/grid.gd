class_name Grid
extends Node2D

@onready var spawn_point: Marker2D = $SpawnPoint
@onready var pieces: Node2D = $Pieces

var grid: Array = []

func _ready():
	# grid[i][j] where
	# i from 0 to HEIGH (20)
	# j from o to WIDTH (10)
	for i in range(Globals.GRID_HEIGHT):
		grid.append([])
		for j in range(Globals.GRID_WIDTH):
			grid[i].append(null)

	position.x = floor(position.x / Globals.BLOCK_SIZE) * Globals.BLOCK_SIZE
	position.y = floor(position.y / Globals.BLOCK_SIZE) * Globals.BLOCK_SIZE

	spawn_point.position.x = (Globals.GRID_WIDTH/2) * Globals.BLOCK_SIZE
	spawn_point.position.y = -2 * Globals.BLOCK_SIZE

func spawn_piece(type: String) -> Piece:
	var piece = Piece.new()
	piece.position = spawn_point.position
	piece.initialize(type)
	pieces.add_child(piece)
	return piece

func can_move(piece: Piece, direction: Vector2) -> bool:
	var offset: Vector2 = direction * Globals.BLOCK_SIZE
	for block in piece.blocks:
		var x = (block.position.x + offset.x + piece.position.x) / Globals.BLOCK_SIZE
		var y = (block.position.y + offset.y + piece.position.y) / Globals.BLOCK_SIZE

		# Out of bounds
		if x < 0 or x >= Globals.GRID_WIDTH or y >= Globals.GRID_HEIGHT:
			return false

		# Collisions
		if y >= 0 and grid[int(y)][int(x)] != null:
			return false
	return true

func place_piece(piece: Piece):
	for block in piece.blocks:
		var x = (block.position.x + piece.position.x) / Globals.BLOCK_SIZE
		var y = (block.position.y + piece.position.y) / Globals.BLOCK_SIZE
		grid[int(y)][int(x)] = block

func clear_lines():
	for y in range(Globals.GRID_HEIGHT):
		if null not in grid[y]:
			for x in range(Globals.GRID_WIDTH):
				grid[y][x].queue_free()
				grid[y][x] = null

			for above_y in range(y, 0, -1):
				for x in range(Globals.GRID_WIDTH):
					grid[above_y][x] = grid[above_y - 1][x]
					if grid[above_y][x]:
						grid[above_y][x].position.y += Globals.BLOCK_SIZE

			var empty_row = []
			for j in range(Globals.GRID_WIDTH):
				empty_row.append(null)
			grid[0] = empty_row
