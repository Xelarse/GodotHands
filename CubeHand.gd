extends Node

var cubes: Array
@export var handedness: XRHandTracker.Hand

func _ready():
	# Populate the cube array with cubes
	var cube = MeshInstance3D.new()
	cube.mesh = BoxMesh.new()
	cube.scale = Vector3(0.1, 0.1, 0.1)
	for ind in range(0,26):
		cubes.push_back(cube.duplicate())

func _process(delta: float) -> void:
	var hand_data_poller = get_parent()
	var hand_data = hand_data_poller.GetLatestHand(handedness)
	
	if hand_data_poller && hand_data:
		for ind in range(0, XRHandTracker.HandJoint.HAND_JOINT_MAX):
			cubes[ind].transform = hand_data[ind as XRHandTracker.HandJoint]
