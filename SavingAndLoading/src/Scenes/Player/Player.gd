extends KinematicBody2D

const TILE_SIZE: int = 32
var is_alive: bool = true

# Inputs para teste do save/load.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		SaveLoad.save()
		
	if Input.is_action_just_pressed("load"):
		SaveLoad.load_game()

# Lógica de movimento do jogador
func _move(delta: float) -> void:
	_move(delta)
	if Input.is_action_just_pressed("ui_left"):
		move_and_collide(Vector2.LEFT * TILE_SIZE)
	if Input.is_action_just_pressed("ui_up"):
		move_and_collide(Vector2.UP * TILE_SIZE)
	if Input.is_action_just_pressed("ui_right"):
		move_and_collide(Vector2.RIGHT * TILE_SIZE)
	if Input.is_action_just_pressed("ui_down"):
		move_and_collide(Vector2.DOWN * TILE_SIZE)
	
	global_position = Vector2(round(global_position.x), round(global_position.y))

# Lógica para jogador pegar chave/abrir porta.
func _on_OverlapDetector_area_entered(area):
	if area.is_in_group("door") and Global.flags.has_key:
		area.get_parent().queue_free()
	elif area.is_in_group("key"):
		Global.flags.has_key = true
		area.queue_free()
