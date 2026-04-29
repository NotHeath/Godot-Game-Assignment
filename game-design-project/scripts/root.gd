extends Node2D

@onready var counter = $Character/Camera2D/CanvasLayer/counter
@onready var player = $Character
var startpoint: float = 0.0

# Ideas: Adding pause menu, adding an autowalking button
# Update: Added counter, reset (instead of pause), and autowalking button

var currentbackground = null # Holds the currently loaded background

func _ready() -> void:
	var chosen = Global.selected_theme
	startpoint = global_position.x
	
	if chosen != "":
		load_background(chosen)
		
		if chosen == "forest":
			forest_loop()
		elif chosen == "mountains":
			Mountain_loop()
		elif chosen == "valley":
			Valley_loop()

# Runs updates contiuously
func _process(delta: float) -> void:
	update_counter()

func update_counter():
	# New Learnings: abs() - Calculates both left and right travel movement.
	var travel_distance = abs(player.global_position.x - startpoint)
	var meters = int(travel_distance / 100) # turns "cm" into "m"
	counter.text = "Distance: " + str(meters) + "m"

# Function to bring player back to meny with reset key (P)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		Global.selected_theme = ""
		Global.auto_walk = false
		Global.is_moving = false
		
		get_tree().change_scene_to_file("res://scenes/main_men.tscn")


# Connect this from the Button's "pressed()" signal in the Node tab
func _on_autowalk_pressed() -> void:
	Global.auto_walk = !Global.auto_walk
	
	# Update the button text
	if Global.auto_walk:
		$Character/Camera2D/CanvasLayer/Autowalk.text = "Auto-Walk: ON"
	else:
		$Character/Camera2D/CanvasLayer/Autowalk.text = "Auto-Walk: OFF"

# Background Manager

func load_background(name: String) -> void:
	# Remove existing background if there is one
	if currentbackground:
		currentbackground.queue_free()
	
	if name == "forest":
		currentbackground = preload("res://scenes/Forest.tscn").instantiate()
	elif name == "valley":
		currentbackground = preload("res://scenes/valley.tscn").instantiate()
	elif name == "mountains":
		currentbackground = preload("res://scenes/mountains.tscn").instantiate()
	
	# Making it a child and layering it behind the character
	add_child(currentbackground)
	move_child(currentbackground, 0)


# Music Management (Pulled off of my MIDI Lab)

# ─── Instrument and Note ─────────────────────────────────────────────────────
# Send a PROGRAM_CHANGE message to swap instrument on a channel

func change_instrument(channel, instrument):
	var midi_event = InputEventMIDI.new()
	midi_event.channel = channel
	midi_event.message = MIDI_MESSAGE_PROGRAM_CHANGE
	midi_event.instrument = instrument
	$MidiPlayer.receive_raw_midi_message(midi_event)


func play_note(note, duration, channel):
	# Start the note
	var m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_ON
	m.pitch = note
	m.velocity = 100
	m.channel = channel
	$MidiPlayer.receive_raw_midi_message(m)
	
	# Wait for the note duration without freezing the engine
	await get_tree().create_timer(duration).timeout
	
	# Stop the note
	m = InputEventMIDI.new()
	m.message = MIDI_MESSAGE_NOTE_OFF
	m.pitch = note
	m.velocity = 100
	m.channel = channel
	$MidiPlayer.receive_raw_midi_message(m)

var tempo: float = 0.25

# ─── Loops ──────────────────────────────────────────────────────────

# Updated loops: Added movement flag to only play music once the character is moving
# Error: Function is not listening to the movement flag and just playing (FIxed)


func forest_loop(): # Drums
	var pattern = [36, 42, 38, 42, 36, 36, 38, 42] 
	while Global.selected_theme == "forest": 
		for i in range(pattern.size()):
			
			# Flag intergrated into the middle of the for loop to stop the beat until I move
			while not Global.is_moving and Global.selected_theme == "forest":
				await get_tree().create_timer(0.1).timeout 
			
			play_note(pattern[i], 0.1, 9) 
			await get_tree().create_timer(tempo).timeout

func Mountain_loop(): # Trumpet
	change_instrument(0, 60)
	var pattern = [67, 67, 72, 67, 64, 60] 
	while Global.selected_theme == "mountains":
		for i in range(pattern.size()):
			
			while not Global.is_moving and Global.selected_theme == "mountains":
				await get_tree().create_timer(0.1).timeout
			
			play_note(pattern[i], 0.3, 0) 
			await get_tree().create_timer(tempo).timeout 

func Valley_loop():  # Guitar
	change_instrument(0, 0)
	var pattern = [60, 64, 67, 72, 67, 64] 
	while Global.selected_theme == "valley":
		for i in range(pattern.size()):
			
			while not Global.is_moving and Global.selected_theme == "valley":
				await get_tree().create_timer(0.1).timeout
			
			play_note(pattern[i], 0.5, 0) 
			await get_tree().create_timer(tempo).timeout
