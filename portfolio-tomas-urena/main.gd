extends Node2D

var colors = [Color.RED,Color.YELLOW,Color.AQUA,Color.GREEN,Color.PURPLE,Color.BLACK,Color.WHITE,Color.SADDLE_BROWN,Color.HOT_PINK]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PROJECT_LIST.visible = false
	$SUMMARY.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_contact_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta)) 
	

@export_file("*.pdf") var pdf_path: String = "res://pdfs//RESUME.pdf"

func _on_resume_button_pressed() -> void:
	if not OS.has_feature("web"):
		push_warning("Blob URL opening only works in Web exports.")
		return
		
	var bytes: PackedByteArray = FileAccess.get_file_as_bytes(pdf_path)
	if bytes.is_empty():
		var err = FileAccess.get_open_error()
		push_error("Failed to load '%s'. Error code: %s (%s)" % [pdf_path, err, error_string(err)])
		return
	
	# Convert Godot's PackedByteArray to a JS Uint8Array
	var js_bytes = Marshalls.raw_to_base64(bytes)
	
	# Decode base64 to Blob and open in a new tab
	var js_code = """
		(function(base64) {
			const binary = atob(base64);
			const len = binary.length;
			const bytes = new Uint8Array(len);
			for (let i = 0; i < len; i++) {
				bytes[i] = binary.charCodeAt(i);
			}
			const blob = new Blob([bytes], { type: 'application/pdf' });
			const url = URL.createObjectURL(blob);
			window.open(url, '_blank', 'noopener,noreferrer');
		})('%s');
	""" % js_bytes
	
	JavaScriptBridge.eval(js_code)
	#OS.shell_open(pdf_path)
	#get_tree().change_scene_to_file("res://resume.tscn")
	#JavaScriptBridge.eval("")
	pass # Replace with function body.


func _on_summary_button_pressed() -> void:
	if $PROJECT_LIST.visible:
		$PROJECT_LIST.visible = false
		$SUMMARY.visible = true
	else:
		$SUMMARY.add_theme_color_override("default_color", colors.pick_random())
	pass # Replace with function body.


func _on_projects_button_pressed() -> void:
	if $SUMMARY.visible:
		$SUMMARY.visible = false
		$PROJECT_LIST.visible = true
	else:
		$PROJECT_LIST.add_theme_color_override("default_color", colors.pick_random())
	pass # Replace with function body.
