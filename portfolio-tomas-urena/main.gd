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
	


func _on_resume_button_pressed() -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval(
			"window.open('pdfs/RESUME.pdf', '_blank');")
	else:
		OS.shell_open("res://pdfs/RESUME.pdf")
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
