extends Node

var gnomon_prefab = preload("res://prefabs/Gnomon.tscn")
var gnomons: Array
@export var handedness: XRHandTracker.Hand
@export var gnomon_scale: Vector3

func _ready():
	for ind in range(0,26):
		var gnomon_instance = gnomon_prefab.instantiate() as Node3D
		self.add_child(gnomon_instance)
		gnomons.push_back(gnomon_instance)

func _process(_delta: float) -> void:
	var hand_data_poller = get_parent()
	var hand_data = hand_data_poller.GetLatestHand(handedness)
	
	if hand_data_poller && hand_data:
		for ind in range(0, XRHandTracker.HandJoint.HAND_JOINT_MAX):
			gnomons[ind].transform = hand_data[ind as XRHandTracker.HandJoint]
			
			# Reapply the scale factor as that transform overwrites it
			gnomons[ind].scale = gnomon_scale
