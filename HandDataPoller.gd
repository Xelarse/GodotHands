extends Node

var left_tracker: XRHandTracker
var right_tracker: XRHandTracker

var latest_left: Dictionary
var latest_right: Dictionary

func _ready():
	var trackers = XRServer.get_hand_trackers()
	
	
func _process(delta: float) -> void:
	# Attempt to fetch the trackers if they haven't already
	if !left_tracker || !right_tracker:
		var trackers = XRServer.get_hand_trackers()
		for key in trackers:
			if key == "/user/left":
				left_tracker = trackers[key]
			elif key == "/user/right":
				right_tracker = trackers[key]
	else:
		for ind in range(0, XRHandTracker.HAND_JOINT_MAX):
			
			latest_left[ind as XRHandTracker.HandJoint] = left_tracker.get_hand_joint_transform(ind)
			latest_right[ind as XRHandTracker.HandJoint] = right_tracker.get_hand_joint_transform(ind)

func GetLatestHand(handedness: XRHandTracker.Hand) -> Dictionary:
	if handedness == XRHandTracker.Hand.HAND_LEFT:
		return latest_left
	else:
		return latest_right
