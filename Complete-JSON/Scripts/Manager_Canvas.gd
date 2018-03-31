extends CanvasLayer

func portuguese_selected():
	set_language("pt")
	
func english_selected():
	set_language("en")

func set_language(lang_prefix):
	var file = File.new()
	file.open("res://Resources/" + lang_prefix + "-texts.json", file.READ)
	var json = parse_json(file.get_as_text())
	
	for child in get_children():
		if child.is_in_group("localizable"):
			child.text = json[str(child.get_name())]
	file.close()