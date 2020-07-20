extends Node

# Constantes utilitárias
const GROUP_TO_SAVE: String = "save"
const SAVE_PATH: String = "res://save.tres"

func save() -> void:
	var game_save: GameSave = GameSave.new()
	var entities: Array = get_tree().get_nodes_in_group(GROUP_TO_SAVE)
#	Inicializa os dicionários para criar o arquivo de save
	game_save.data["entities"] = {}
	game_save.data["flags"] = {}
	
#		Guardamos o valor de cada flag e entidade dinamicamente a partir
#		desses dois loops.
	for flag in Global.flags:
		game_save.data.flags[flag] = Global.flags[flag]
	
	for entity in entities:
		game_save.data.entities[entity.name] = {}
		game_save.data.entities[entity.name].position = entity.global_position

#	Checamos se houve algum erro no salvamento para ajudar no debug do jogo.
	var error := ResourceSaver.save(SAVE_PATH, game_save)
	if error != OK:
		push_error("Error %d trying to save at %s" % [error, SAVE_PATH])
		return

func load_game() -> void:
#	Existe o arquivo "res://save.tres"?
	if ResourceLoader.exists(SAVE_PATH):
		var game_save: Resource = load(SAVE_PATH)
		var entities: Array = get_tree().get_nodes_in_group(GROUP_TO_SAVE)
		
#		Atribuímos o valor de cada flag e entidade dinamicamente a partir
#		desses dois loops.
		for flag in game_save.data.flags:
			 Global.flags[flag] = game_save.data.flags[flag]
		
		for entity in entities:
			if not game_save.data.entities.has(entity.name):
				entity.queue_free()
				continue
				
			entity.global_position = game_save.data.entities[entity.name].position
