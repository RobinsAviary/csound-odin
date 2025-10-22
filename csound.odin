package csound

import "core:c"
foreign import lib "lib/csound64.lib"

State :: struct {}

@(default_calling_convention="c")
foreign lib {
	@(link_name="csoundCreate")
	create :: proc(hostData: rawptr = nil) -> ^State ---

	@(link_name="csoundCompile")
	compile :: proc(state: ^State, argc: c.int, argv: [^]cstring) -> c.int ---

	@(link_name="csoundPerformKsmps")
	performKsmps :: proc(state: ^State) ---
	
	@(link_name="csoundCleanup")
	cleanup :: proc(state: ^State) ---

	@(link_name="csoundDestroy")
	destroy :: proc(state: ^State) ---
}