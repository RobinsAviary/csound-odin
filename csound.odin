package csound

import "core:c"
foreign import lib "csound64.lib"

CSOUND :: struct {}

TREE :: struct {}

@(default_calling_convention="c")
foreign lib {
	@(link_name="csoundCreate")
	create :: proc(hostData: rawptr = nil) -> ^CSOUND ---

	@(link_name="csoundCompile")
	compile :: proc(csound: ^CSOUND, argc: c.int, argv: [^]cstring) -> c.int ---

	@(link_name="csoundPerformKsmps")
	performKsmps :: proc(csound: ^CSOUND) ---
	
	@(link_name="csoundCleanup")
	cleanup :: proc(csound: ^CSOUND) ---

	@(link_name="csoundDestroy")
	destroy :: proc(csound: ^CSOUND) ---

	@(link_name="csoundInitialize")
	initialize :: proc(flags: c.int) -> c.int ---

	@(link_name="csoundSetOpcodeDir")
	setOpcodeDir :: proc(s: cstring) ---

	@(link_name="csoundLoadPlugins")
	loadPlugins :: proc(csound: ^CSOUND, dir: cstring) -> c.int ---

	@(link_name="csoundGetVersion")
	getVersion :: proc() -> c.int ---

	@(link_name="csoundGetAPIVersion")
	getAPIVersion :: proc() -> c.int ---

	@(link_name="csoundParseOrc")
	parseOrc :: proc(csound: ^CSOUND, str: cstring) -> ^TREE ---

	@(link_name="csoundCompileTree")
	compileTree :: proc(csound: ^CSOUND, root: ^TREE) -> c.int ---

	
}