extends Node

var xr_interface: XRInterface
var viewport: Viewport

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	viewport = get_viewport()
	
	if xr_interface && viewport && xr_interface.is_initialized():
		print("OpenXR init successful")
		
		# Vsync disable to make sure monitor RR isn't being forced on headset.
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		# Change the main viewport to output to the HMD
		viewport.use_xr = true
		
		# Attempt to start the app in passthrough mode
		enable_passthrough()
		
	else:
		print("OpenXR failed to initialize.")


func enable_passthrough():
	var modes = xr_interface.get_supported_environment_blend_modes()
	if xr_interface.XR_ENV_BLEND_MODE_ALPHA_BLEND in modes:
		xr_interface.set_environment_blend_mode(xr_interface.XR_ENV_BLEND_MODE_ALPHA_BLEND)
		viewport.transparent_bg = true
