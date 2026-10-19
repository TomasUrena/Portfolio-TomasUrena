extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_contact_meta_clicked(meta: Variant) -> void:
	OS.shell_open(str(meta)) 
	


func _on_resume_button_pressed() -> void:
	# For a local file inside res:// or user:// /Users/tomasurena/Desktop/CS_371/cs371-fa2023-individual-TomasUrena/Portfolio-TomasUrena/portfolio-tomas-urena/RESUME_TWO\ copy.pdf
	# file:///Users/tomasurena/Desktop/CS_371/cs371-fa2023-individual-TomasUrena/Portfolio-TomasUrena/portfolio-tomas-urena/RESUME.pdf
	var pdf_path = ProjectSettings.globalize_path("res://path/to/RESUME.pdf")
	OS.shell_open(pdf_path)
	pass # Replace with function body.
