package csound_cli

import "../../" // Imports csound

import "core:os"
import "core:strings"

main :: proc() {
	argv: []string = os.args

	argvc := make([]cstring, len(os.args))
	for arg, i in argv {
		argvc[i] = strings.clone_to_cstring(arg, context.temp_allocator)
	}

	state := csound.create(rawptr(uintptr(0)))
	
	result := csound.compile(state, i32(len(argv)), raw_data(argvc))
	if result == 0 {
		csound.start(state)
		for csound.performKsmps(state) == 0 {}
		csound.cleanup(state)
	}
	
	csound.destroy(state)

	free_all(context.temp_allocator)
	delete(argvc)
}