package csound_cli

import "../../csound" // Imports csound

import "core:os"
import "core:strings"

main :: proc() {
	argv: []string = os.args

	argvc := make([]cstring, len(os.args))
	for arg, i in argv {
		argvc[i] = strings.clone_to_cstring(arg, context.temp_allocator)
	}

	state := csound.Create(rawptr(uintptr(0)))
	
	result := csound.Compile(state, i32(len(argv)), raw_data(argvc))
	if result == 0 {
		csound.Start(state)
		for csound.PerformKsmps(state) == 0 {}
		csound.Cleanup(state)
	}
	
	csound.Destroy(state)

	free_all(context.temp_allocator)
	delete(argvc)
}