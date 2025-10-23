/*
    csound.h:

    Copyright (C) 2003 2005 2008 2013 by John ffitch, Istvan Varga,
                                         Mike Gogins, Victor Lazzarini,
                                         Andres Cabrera, Steven Yi

    This file is part of Csound.

    The Csound Library is free software; you can redistribute it
    and/or modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    Csound is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with Csound; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
    02110-1301 USA
*/
package csound

import "core:c"

foreign import lib "csound64.lib"
_ :: lib

/**
* ERROR DEFINITIONS
*/
CSOUND_STATUS :: enum i32 {
	/* Completed successfully. */
	SUCCESS        = 0,

	/* Unspecified failure. */
	ERROR          = -1,

	/* Failed during initialization. */
	INITIALIZATION = -2,

	/* Failed during performance. */
	PERFORMANCE    = -3,

	/* Failed to allocate requested memory. */
	MEMORY         = -4,

	/* Termination requested by SIGINT or SIGTERM. */
	SIGNAL         = -5,
}

/* Compilation or performance aborted, but not as a result of an error
(e.g. --help, or running an utility with -U). */
CSOUND_EXITJMP_SUCCESS  :: (256)

/**
* Flags for csoundInitialize().
*/
CSOUNDINIT_NO_SIGNAL_HANDLER  :: 1
CSOUNDINIT_NO_ATEXIT          :: 2

/**
* Types for keyboard callbacks set in csoundRegisterKeyboardCallback()
*/
CSOUND_CALLBACK_KBD_EVENT   :: (0x00000001)
CSOUND_CALLBACK_KBD_TEXT    :: (0x00000002)

/**
* The following constants are used with csound->FileOpen2() and
* csound->ldmemfile2() to specify the format of a file that is being
* opened.  This information is passed by Csound to a host's FileOpen
* callback and does not influence the opening operation in any other
* way. Conversion from Csound's TYP_XXX macros for audio formats to
* CSOUND_FILETYPES values can be done with csound->type2csfiletype().
*/
CSOUND_FILETYPES :: enum i32 {
	UNIFIED_CSD    = 1,  /* Unified Csound document */
	ORCHESTRA      = 2,  /* the primary orc file (may be temporary) */
	SCORE          = 3,  /* the primary sco file (may be temporary)
                                  or any additional score opened by Cscore */
	ORC_INCLUDE    = 4,  /* a file #included by the orchestra */
	SCO_INCLUDE    = 5,  /* a file #included by the score */
	SCORE_OUT      = 6,  /* used for score.srt, score.xtr, cscore.out */
	SCOT           = 7,  /* Scot score input format */
	OPTIONS        = 8,  /* for .csoundrc and -@ flag */
	EXTRACT_PARMS  = 9,  /* extraction file specified by -x */

	/* audio file types that Csound can write (10-19) or read */
	RAW_AUDIO      = 10,
	IRCAM          = 11,
	AIFF           = 12,
	AIFC           = 13,
	WAVE           = 14,
	AU             = 15,
	SD2            = 16,
	W64            = 17,
	WAVEX          = 18,
	FLAC           = 19,
	CAF            = 20,
	WVE            = 21,
	OGG            = 22,
	MPC2K          = 23,
	RF64           = 24,
	AVR            = 25,
	HTK            = 26,
	MAT4           = 27,
	MAT5           = 28,
	NIST           = 29,
	PAF            = 30,
	PVF            = 31,
	SDS            = 32,
	SVX            = 33,
	VOC            = 34,
	XI             = 35,
	MPEG           = 36,
	UNKNOWN_AUDIO  = 37, /* used when opening audio file for reading
                                  or temp file written with <CsSampleB> */

	/* miscellaneous music formats */
	SOUNDFONT      = 38,
	STD_MIDI       = 39, /* Standard MIDI file */
	MIDI_SYSEX     = 40, /* Raw MIDI codes, eg. SysEx dump */

	/* analysis formats */
	HETRO          = 41,
	HETROT         = 42,
	PVC            = 43, /* original PVOC format */
	PVCEX          = 44, /* PVOC-EX format */
	CVANAL         = 45,
	LPC            = 46,
	ATS            = 47,
	LORIS          = 48,
	SDIF           = 49,
	HRTF           = 50,

	/* Types for plugins and the files they read/write */
	UNUSED         = 51,
	LADSPA_PLUGIN  = 52,
	SNAPSHOT       = 53,

	/* Special formats for Csound ftables or scanned synthesis
	matrices with header info */
	FTABLES_TEXT   = 54, /* for ftsave and ftload  */
	FTABLES_BINARY = 55, /* for ftsave and ftload  */
	XSCANU_MATRIX  = 56, /* for xscanu opcode  */

	/* These are for raw lists of numbers without header info */
	FLOATS_TEXT    = 57, /* used by GEN23, GEN28, dumpk, readk */
	FLOATS_BINARY  = 58, /* used by dumpk, readk, etc. */
	INTEGER_TEXT   = 59, /* used by dumpk, readk, etc. */
	INTEGER_BINARY = 60, /* used by dumpk, readk, etc. */

	/* image file formats */
	IMAGE_PNG      = 61,

	/* For files that don't match any of the above */
	POSTSCRIPT     = 62, /* EPS format used by graphs */
	SCRIPT_TEXT    = 63, /* executable script files (eg. Python) */
	OTHER_TEXT     = 64,
	OTHER_BINARY   = 65,

	/* This should only be used internally by the original FileOpen()
	API call or for temp files written with <CsFileB> */
	UNKNOWN        = 0,
}

/*
* Forward declarations.
*/
CSOUND   :: CSOUND_
CSOUND_  :: struct {}
WINDAT   :: windat_
windat_  :: struct {}
xyindat_ :: struct {}
XYINDAT  :: xyindat_

/**
*  csound configuration structure, mirrors part of
*  OPARMS, uses more meaningful names
*/
CSOUND_PARAMS :: struct {
	debug_mode:             i32, /* debug mode, 0 or 1 */
	buffer_frames:          i32, /* number of frames in in/out buffers */
	hardware_buffer_frames: i32, /* ibid. hardware */
	displays:               i32, /* graph displays, 0 or 1 */
	ascii_graphs:           i32, /* use ASCII graphs, 0 or 1 */
	postscript_graphs:      i32, /* use postscript graphs, 0 or 1 */
	message_level:          i32, /* message printout control */
	tempo:                  i32, /* tempo (sets Beatmode)  */
	ring_bell:              i32, /* bell, 0 or 1 */
	use_cscore:             i32, /* use cscore for processing */
	terminate_on_midi:      i32, /* terminate performance at the end
                                  of midifile, 0 or 1 */
	heartbeat:              i32, /* print heart beat, 0 or 1 */
	defer_gen01_load:       i32, /* defer GEN01 load, 0 or 1 */
	midi_key:               i32, /* pfield to map midi key no */
	midi_key_cps:           i32, /* pfield to map midi key no as cps */
	midi_key_oct:           i32, /* pfield to map midi key no as oct */
	midi_key_pch:           i32, /* pfield to map midi key no as pch */
	midi_velocity:          i32, /* pfield to map midi velocity */
	midi_velocity_amp:      i32, /* pfield to map midi velocity as amplitude */
	no_default_paths:       i32, /* disable relative paths from files, 0 or 1 */
	number_of_threads:      i32, /* number of threads for multicore performance */
	syntax_check_only:      i32, /* do not compile, only check syntax */
	csd_line_counts:        i32, /* csd line error reporting */
	compute_weights:        i32, /* deprecated, kept for backwards comp.  */
	realtime_mode:          i32, /* use realtime priority mode, 0 or 1 */
	sample_accurate:        i32, /* use sample-level score event accuracy */
	sample_rate_override:   i32, /* overriding sample rate */
	control_rate_override:  i32, /* overriding control rate */
	nchnls_override:        i32, /* overriding number of out channels */
	nchnls_i_override:      i32, /* overriding number of in channels */
	e0dbfs_override:        i32, /* overriding 0dbfs */
	daemon:                 i32, /* daemon mode */
	ksmps_override:         i32, /* ksmps override */
	FFT_library:            i32, /* fft_lib */
}

/**
* Device information
*/
CS_AUDIODEVICE :: struct {
	device_name: [128]i8,
	device_id:   [128]i8,
	rt_module:   [128]i8,
	max_nchnls:  i32,
	isOutput:    i32,
}

CS_MIDIDEVICE :: struct {
	device_name:    [128]i8,
	interface_name: [128]i8,
	device_id:      [128]i8,
	midi_module:    [128]i8,
	isOutput:       i32,
}

/**
* Real-time audio parameters structure
*/
csRtAudioParams :: struct {
	/** device name (NULL/empty: default) */
	devName: cstring,

	/** device number (0-1023), 1024: default */
	devNum: i32,

	/** buffer fragment size (-b) in sample frames */
	bufSamp_SW: u32,

	/** total buffer size (-B) in sample frames */
	bufSamp_HW: i32,

	/** number of channels */
	nChannels: i32,

	/** sample format (AE_SHORT etc.) */
	sampleFormat: i32,

	/** sample rate in Hz */
	sampleRate: f32,
}

RTCLOCK_S :: struct {
	starttime_real: i32,
	starttime_CPU:  i32,
}

RTCLOCK :: RTCLOCK_S

opcodeListEntry :: struct {
	opname:  cstring,
	outypes: cstring,
	intypes: cstring,
	flags:   i32,
}

CsoundRandMTState_ :: struct {
	mti: i32,
	mt:  [624]i32,
}

CsoundRandMTState :: CsoundRandMTState_

/* PVSDATEXT is a variation on PVSDAT used in
the pvs bus interface */
pvsdat_ext :: struct {
	N:          i32,
	sliding:    i32, /* Flag to indicate sliding case */
	NB:         i32,
	overlap:    i32,
	winsize:    i32,
	wintype:    i32,
	format:     i32,
	framecount: i32,
	frame:      ^f32,
}

/* PVSDATEXT is a variation on PVSDAT used in
the pvs bus interface */
PVSDATEXT :: pvsdat_ext

ORCTOKEN :: struct {
	type:   i32,
	lexeme: cstring,
	value:  i32,
	fvalue: f64,
	optype: cstring,
	next:   ^ORCTOKEN,
}

TREE :: struct {
	type:   i32,
	value:  ^ORCTOKEN,
	rate:   i32,
	len:    i32,
	line:   i32,
	locn:   i32,
	left:   ^TREE,
	right:  ^TREE,
	next:   ^TREE,
	markup: rawptr, // TEMPORARY - used by semantic checker to
}

/**
* Constants used by the bus interface (csoundGetChannelPtr() etc.).
*/
controlChannelType :: enum i32 {
	CONTROL_CHANNEL   = 1,
	AUDIO_CHANNEL     = 2,
	STRING_CHANNEL    = 3,
	PVS_CHANNEL       = 4,
	VAR_CHANNEL       = 5,
	CHANNEL_TYPE_MASK = 15,
	INPUT_CHANNEL     = 16,
	OUTPUT_CHANNEL    = 32,
}

controlChannelBehavior :: enum i32 {
	NO_HINTS = 0,
	INT      = 1,
	LIN      = 2,
	EXP      = 3,
}

/**
* This structure holds the parameter hints for control channels
*
*/
controlChannelHints_s :: struct {
	behav:  controlChannelBehavior,
	dflt:   i32,
	min:    i32,
	max:    i32,
	x:      i32,
	y:      i32,
	width:  i32,
	height: i32,

	/** This member must be set explicitly to NULL if not used */
	attributes: cstring,
}

/**
* This structure holds the parameter hints for control channels
*
*/
controlChannelHints_t :: controlChannelHints_s

controlChannelInfo_s :: struct {
	name:  cstring,
	type:  i32,
	hints: controlChannelHints_t,
}

controlChannelInfo_t :: controlChannelInfo_s
channelCallback_t    :: proc "c" (csound: ^CSOUND, channelName: cstring, channelValuePtr: rawptr, channelType: rawptr)

@(default_calling_convention="c", link_prefix="csound")
foreign lib {
	/** @defgroup INSTANTIATION Instantiation
	*
	*  @{ */
	/**
	* Initialise Csound library with specific flags. This function is called
	* internally by csoundCreate(), so there is generally no need to use it
	* explicitly unless you need to avoid default initilization that sets
	* signal handlers and atexit() callbacks.
	* Return value is zero on success, positive if initialisation was
	* done already, and negative on error.
	*/
	Initialize :: proc(flags: i32) -> i32 ---

	/**
	* Sets an opcodedir override for csoundCreate()
	*/
	SetOpcodedir :: proc(s: cstring) ---

	/**
	* Creates an instance of Csound.  Returns an opaque pointer that
	* must be passed to most Csound API functions.  The hostData
	* parameter can be NULL, or it can be a pointer to any sort of
	* data; this pointer can be accessed from the Csound instance
	* that is passed to callback routines.
	*/
	Create :: proc(hostData: rawptr) -> ^CSOUND ---

	/**
	*  Loads all plugins from a given directory
	*/
	LoadPlugins :: proc(csound: ^CSOUND, dir: cstring) -> i32 ---

	/**
	* Destroys an instance of Csound.
	*/
	Destroy :: proc(^CSOUND) ---

	/**
	* Returns the version number times 1000 (5.00.0 = 5000).
	*/
	GetVersion :: proc() -> i32 ---

	/**
	* Returns the API version number times 100 (1.00 = 100).
	*/
	GetAPIVersion :: proc() -> i32 ---

	/** @defgroup PERFORMANCE Performance
	*
	*  @{ */
	/**
	* Parse the given orchestra from an ASCII string into a TREE.
	* This can be called during performance to parse new code.
	*/
	ParseOrc :: proc(csound: ^CSOUND, str: cstring) -> ^TREE ---

	/**
	* Compile the given TREE node into structs for Csound to use
	* this can be called during performance to compile a new TREE
	*/
	CompileTree :: proc(csound: ^CSOUND, root: ^TREE) -> i32 ---

	/**
	* Asynchronous version of csoundCompileTree()
	*/
	CompileTreeAsync :: proc(csound: ^CSOUND, root: ^TREE) -> i32 ---

	/**
	* Free the resources associated with the TREE *tree
	* This function should be called whenever the TREE was
	* created with csoundParseOrc and memory can be deallocated.
	**/
	DeleteTree :: proc(csound: ^CSOUND, tree: ^TREE) ---

	/**
	* Parse, and compile the given orchestra from an ASCII string,
	* also evaluating any global space code (i-time only)
	* this can be called during performance to compile a new orchestra.
	* /code
	*       char *orc = "instr 1 \n a1 rand 0dbfs/4 \n out a1 \n";
	*       csoundCompileOrc(csound, orc);
	* /endcode
	*/
	CompileOrc :: proc(csound: ^CSOUND, str: cstring) -> i32 ---

	/**
	*  Async version of csoundCompileOrc(). The code is parsed and
	*  compiled, then placed on a queue for
	*  asynchronous merge into the running engine, and evaluation.
	*  The function returns following parsing and compilation.
	*/
	CompileOrcAsync :: proc(csound: ^CSOUND, str: cstring) -> i32 ---

	/**
	*   Parse and compile an orchestra given on an string,
	*   evaluating any global space code (i-time only).
	*   On SUCCESS it returns a value passed to the
	*   'return' opcode in global space
	* /code
	*       char *code = "i1 = 2 + 2 \n return i1 \n";
	*       MYFLT retval = csoundEvalCode(csound, code);
	* /endcode
	*/
	EvalCode :: proc(csound: ^CSOUND, str: cstring) -> i32 ---

	/**
	* Prepares an instance of Csound for Cscore
	* processing outside of running an orchestra (i.e. "standalone Cscore").
	* It is an alternative to csoundCompile(), and
	* csoundPerform*() and should not be used with these functions.
	* You must call this function before using the interface in "cscore.h"
	* when you do not wish to compile an orchestra.
	* Pass it the already open FILE* pointers to the input and
	* output score files.
	* It returns CSOUND_SUCCESS on success and CSOUND_INITIALIZATION or other
	* error code if it fails.
	*/
	InitializeCscore :: proc(_: ^CSOUND, insco: ^FILE, outsco: ^FILE) -> i32 ---

	/**
	*  Read arguments, parse and compile an orchestra, read, process and
	*  load a score.
	*/
	CompileArgs :: proc(_: ^CSOUND, argc: i32, argv: ^cstring) -> i32 ---

	/**
	* Prepares Csound for performance. Normally called after compiling
	* a csd file or an orc file, in which case score preprocessing is
	* performed and performance terminates when the score terminates.
	*
	* However, if called before compiling a csd file or an orc file,
	* score preprocessing is not performed and "i" statements are dispatched
	* as real-time events, the <CsOptions> tag is ignored, and performance
	* continues indefinitely or until ended using the API.
	*/
	Start :: proc(csound: ^CSOUND) -> i32 ---

	/**
	* Compiles Csound input files (such as an orchestra and score, or CSD)
	* as directed by the supplied command-line arguments,
	* but does not perform them. Returns a non-zero error code on failure.
	* This function cannot be called during performance, and before a
	* repeated call, csoundReset() needs to be called.
	* In this (host-driven) mode, the sequence of calls should be as follows:
	* /code
	*       csoundCompile(csound, argc, argv);
	*       while (!csoundPerformBuffer(csound));
	*       csoundCleanup(csound);
	*       csoundReset(csound);
	* /endcode
	*  Calls csoundStart() internally.
	*  Can only be called again after reset (see csoundReset())
	*/
	Compile :: proc(_: ^CSOUND, argc: i32, argv: ^cstring) -> i32 ---

	/**
	* Compiles a Csound input file (CSD, .csd file), but does not perform it.
	* Returns a non-zero error code on failure.
	*
	* If csoundStart is called before csoundCompileCsd, the <CsOptions>
	* element is ignored (but csoundSetOption can be called any number of
	* times), the <CsScore> element is not pre-processed, but dispatched as
	* real-time events; and performance continues indefinitely, or until
	* ended by calling csoundStop or some other logic. In this "real-time"
	* mode, the sequence of calls should be:
	*
	* \code
	*
	* csoundSetOption("-an_option");
	* csoundSetOption("-another_option");
	* csoundStart(csound);
	* csoundCompileCsd(csound, csd_filename);
	* while (1) {
	*    csoundPerformBuffer(csound);
	*    // Something to break out of the loop
	*    // when finished here...
	* }
	* csoundCleanup(csound);
	* csoundReset(csound);
	*
	* \endcode
	*
	* NB: this function can be called repeatedly during performance to
	* replace or add new instruments and events.
	*
	* But if csoundCompileCsd is called before csoundStart, the <CsOptions>
	* element is used, the <CsScore> section is pre-processed and dispatched
	* normally, and performance terminates when the score terminates, or
	* csoundStop is called. In this "non-real-time" mode (which can still
	* output real-time audio and handle real-time events), the sequence of
	* calls should be:
	*
	* \code
	*
	* csoundCompileCsd(csound, csd_filename);
	* csoundStart(csound);
	* while (1) {
	*    int finished = csoundPerformBuffer(csound);
	*    if (finished) break;
	* }
	* csoundCleanup(csound);
	* csoundReset(csound);
	*
	* \endcode
	*
	*/
	CompileCsd :: proc(csound: ^CSOUND, csd_filename: cstring) -> i32 ---

	/**
	* Behaves the same way as csoundCompileCsd, except that the content
	* of the CSD is read from the csd_text string rather than from a file.
	* This is convenient when it is desirable to package the csd as part of
	* an application or a multi-language piece.
	*/
	CompileCsdText :: proc(csound: ^CSOUND, csd_text: cstring) -> i32 ---

	/**
	* Senses input events and performs audio output until the end of score
	* is reached (positive return value), an error occurs (negative return
	* value), or performance is stopped by calling csoundStop() from another
	* thread (zero return value).
	* Note that csoundCompile() or csoundCompileOrc(), csoundReadScore(),
	* csoundStart() must be called first.
	* In the case of zero return value, csoundPerform() can be called again
	* to continue the stopped performance. Otherwise, csoundReset() should be
	* called to clean up after the finished or failed performance.
	*/
	Perform :: proc(^CSOUND) -> i32 ---

	/**
	* Senses input events, and performs one control sample worth (ksmps) of
	* audio output.
	* Note that csoundCompile() or csoundCompileOrc(), csoundReadScore(),
	* csoundStart() must be called first.
	* Returns false during performance, and true when performance is finished.
	* If called until it returns true, will perform an entire score.
	* Enables external software to control the execution of Csound,
	* and to synchronize performance with audio input and output.
	*/
	PerformKsmps :: proc(^CSOUND) -> i32 ---

	/**
	* Performs Csound, sensing real-time and score events
	* and processing one buffer's worth (-b frames) of interleaved audio.
	* Note that csoundCompile must be called first, then call
	* csoundGetOutputBuffer() and csoundGetInputBuffer() to get the pointer
	* to csound's I/O buffers.
	* Returns false during performance, and true when performance is finished.
	*/
	PerformBuffer :: proc(^CSOUND) -> i32 ---

	/**
	* Stops a csoundPerform() running in another thread. Note that it is
	* not guaranteed that csoundPerform() has already stopped when this
	* function returns.
	*/
	Stop :: proc(^CSOUND) ---

	/**
	* Prints information about the end of a performance, and closes audio
	* and MIDI devices.
	* Note: after calling csoundCleanup(), the operation of the perform
	* functions is undefined.
	*/
	Cleanup :: proc(^CSOUND) -> i32 ---

	/**
	* Resets all internal memory and state in preparation for a new performance.
	* Enables external software to run successive Csound performances
	* without reloading Csound. Implies csoundCleanup(), unless already called.
	*/
	Reset :: proc(^CSOUND) ---

	/**
	* Starts the UDP server on a supplied port number
	* returns CSOUND_SUCCESS if server has been started successfully,
	* otherwise, CSOUND_ERROR.
	*/
	UDPServerStart :: proc(csound: ^CSOUND, port: u32) -> i32 ---

	/** returns the port number on which the server is running, or
	*  CSOUND_ERROR if the server is not running.
	*/
	UDPServerStatus :: proc(csound: ^CSOUND) -> i32 ---

	/**
	* Closes the UDP server, returning CSOUND_SUCCESS if the
	* running server was successfully closed, CSOUND_ERROR otherwise.
	*/
	UDPServerClose :: proc(csound: ^CSOUND) -> i32 ---

	/**
	* Turns on the transmission of console messages to UDP on address addr
	* port port. If mirror is one, the messages will continue to be
	* sent to the usual destination (see csoundSetMessaggeCallback())
	* as well as to UDP.
	* returns CSOUND_SUCCESS or CSOUND_ERROR if the UDP transmission
	* could not be set up.
	*/
	UDPConsole :: proc(csound: ^CSOUND, addr: cstring, port: i32, mirror: i32) -> i32 ---

	/**
	* Stop transmitting console messages via UDP
	*/
	StopUDPConsole :: proc(csound: ^CSOUND) ---

	/**
	* Returns the number of audio sample frames per second.
	*/
	GetSr :: proc(^CSOUND) -> i32 ---

	/**
	* Returns the number of control samples per second.
	*/
	GetKr :: proc(^CSOUND) -> i32 ---

	/**
	* Returns the number of audio sample frames per control sample.
	*/
	GetKsmps :: proc(^CSOUND) -> i32 ---

	/**
	* Returns the number of audio output channels. Set through the nchnls
	* header variable in the csd file.
	*/
	GetNchnls :: proc(^CSOUND) -> i32 ---

	/**
	* Returns the number of audio input channels. Set through the
	* nchnls_i header variable in the csd file. If this variable is
	* not set, the value is taken from nchnls.
	*/
	GetNchnlsInput :: proc(csound: ^CSOUND) -> i32 ---

	/**
	* Returns the 0dBFS level of the spin/spout buffers.
	*/
	Get0dBFS :: proc(^CSOUND) -> i32 ---

	/**
	* Returns the A4 frequency reference
	*/
	GetA4 :: proc(^CSOUND) -> i32 ---

	/**
	* Return the current performance time in samples
	*/
	GetCurrentTimeSamples :: proc(csound: ^CSOUND) -> i32 ---

	/**
	* Return the size of MYFLT in bytes.
	*/
	GetSizeOfMYFLT :: proc() -> i32 ---

	/**
	* Returns host data.
	*/
	GetHostData :: proc(^CSOUND) -> rawptr ---

	/**
	* Sets host data.
	*/
	SetHostData :: proc(_: ^CSOUND, hostData: rawptr) ---

	/**
	* Set a single csound option (flag). Returns CSOUND_SUCCESS on success.
	* NB: blank spaces are not allowed
	*/
	SetOption :: proc(csound: ^CSOUND, option: cstring) -> i32 ---

	/**
	*  Configure Csound with a given set of parameters defined in
	*  the CSOUND_PARAMS structure. These parameters are the part of the
	*  OPARMS struct that are configurable through command line flags.
	*  The CSOUND_PARAMS structure can be obtained using csoundGetParams().
	*  These options should only be changed before performance has started.
	*/
	SetParams :: proc(csound: ^CSOUND, p: ^CSOUND_PARAMS) ---

	/**
	*  Get the current set of parameters from a CSOUND instance in
	*  a CSOUND_PARAMS structure. See csoundSetParams().
	*/
	GetParams :: proc(csound: ^CSOUND, p: ^CSOUND_PARAMS) ---

	/**
	* Returns whether Csound is set to print debug messages sent through the
	* DebugMsg() internal API function. Anything different to 0 means true.
	*/
	GetDebug :: proc(^CSOUND) -> i32 ---

	/**
	* Sets whether Csound prints debug messages from the DebugMsg() internal
	* API function. Anything different to 0 means true.
	*/
	SetDebug :: proc(_: ^CSOUND, debug: i32) ---

	/**
	* If val > 0, sets the internal variable holding the system HW sr.
	* Returns the stored value containing the system HW sr.
	*/
	SystemSr :: proc(csound: ^CSOUND, val: i32) -> i32 ---

	/**
	* Returns the audio output name (-o).
	*/
	GetOutputName :: proc(^CSOUND) -> cstring ---

	/**
	* Returns the audio input name (-i).
	*/
	GetInputName :: proc(^CSOUND) -> cstring ---

	/**
	*  Set output destination, type and format
	*  type can be one of  "wav","aiff", "au","raw", "paf", "svx", "nist", "voc",
	*  "ircam","w64","mat4", "mat5", "pvf","xi", "htk","sds","avr","wavex","sd2",
	*  "flac", "caf","wve","ogg","mpc2k","rf64", or NULL (use default or
	*  realtime IO).
	*  format can be one of "alaw", "schar", "uchar", "float", "double", "long",
	*  "short", "ulaw", "24bit", "vorbis", or NULL (use default or realtime IO).
	*   For RT audio, use device_id from CS_AUDIODEVICE for a given audio device.
	*
	*/
	SetOutput :: proc(csound: ^CSOUND, name: cstring, type: cstring, format: cstring) ---

	/**
	*  Get output type and format.
	*  type should have space for at least 5 chars excluding termination,
	*  and format should have space for at least 7 chars.
	*  On return, these will hold the current values for
	*  these parameters.
	*/
	GetOutputFormat :: proc(csound: ^CSOUND, type: cstring, format: cstring) ---

	/**
	*  Set input source
	*/
	SetInput :: proc(csound: ^CSOUND, name: cstring) ---

	/**
	*  Set MIDI input device name/number
	*/
	SetMIDIInput :: proc(csound: ^CSOUND, name: cstring) ---

	/**
	*  Set MIDI file input name
	*/
	SetMIDIFileInput :: proc(csound: ^CSOUND, name: cstring) ---

	/**
	*  Set MIDI output device name/number
	*/
	SetMIDIOutput :: proc(csound: ^CSOUND, name: cstring) ---

	/**
	*  Set MIDI file utput name
	*/
	SetMIDIFileOutput :: proc(csound: ^CSOUND, name: cstring) ---

	/**
	* Sets an external callback for receiving notices whenever Csound opens
	* a file.  The callback is made after the file is successfully opened.
	* The following information is passed to the callback:
	*     char*  pathname of the file; either full or relative to current dir
	*     int    a file type code from the enumeration CSOUND_FILETYPES
	*     int    1 if Csound is writing the file, 0 if reading
	*     int    1 if a temporary file that Csound will delete; 0 if not
	*
	* Pass NULL to disable the callback.
	* This callback is retained after a csoundReset() call.
	*/
	SetFileOpenCallback :: proc(p: ^CSOUND, func: proc "c" (^CSOUND, cstring, i32, i32, i32)) ---

	/**
	*  Sets the current RT audio module
	*/
	SetRTAudioModule :: proc(csound: ^CSOUND, module: cstring) ---

	/**
	* retrieves a module name and type ("audio" or "midi") given a
	* number Modules are added to list as csound loads them returns
	* CSOUND_SUCCESS on success and CSOUND_ERROR if module number
	* was not found
	*
	* \code
	*  char *name, *type;
	*  int n = 0;
	*  while(!csoundGetModule(csound, n++, &name, &type))
	*       printf("Module %d:  %s (%s) \n", n, name, type);
	* \endcode
	*/
	GetModule :: proc(csound: ^CSOUND, number: i32, name: ^cstring, type: ^cstring) -> i32 ---

	/**
	* Returns the number of samples in Csound's input buffer.
	*/
	GetInputBufferSize :: proc(^CSOUND) -> c.long ---

	/**
	* Returns the number of samples in Csound's output buffer.
	*/
	GetOutputBufferSize :: proc(^CSOUND) -> c.long ---

	/**
	* Returns the address of the Csound audio input buffer.
	* Enables external software to write audio into Csound before calling
	* csoundPerformBuffer.
	*/
	GetInputBuffer :: proc(^CSOUND) -> ^i32 ---

	/**
	* Returns the address of the Csound audio output buffer.
	* Enables external software to read audio from Csound after calling
	* csoundPerformBuffer.
	*/
	GetOutputBuffer :: proc(^CSOUND) -> ^i32 ---

	/**
	* Returns the address of the Csound audio input working buffer (spin).
	* Enables external software to write audio into Csound before calling
	* csoundPerformKsmps.
	*/
	GetSpin :: proc(^CSOUND) -> ^i32 ---

	/**
	* Clears the input buffer (spin).
	*/
	ClearSpin :: proc(^CSOUND) ---

	/**
	* Adds the indicated sample into the audio input working buffer (spin);
	* this only ever makes sense before calling csoundPerformKsmps().
	* The frame and channel must be in bounds relative to ksmps and nchnls.
	* NB: the spin buffer needs to be cleared at every k-cycle by calling
	* csoundClearSpinBuffer().
	*/
	AddSpinSample :: proc(csound: ^CSOUND, frame: i32, channel: i32, sample: i32) ---

	/**
	* Sets the audio input working buffer (spin) to the indicated sample
	* this only ever makes sense before calling csoundPerformKsmps().
	* The frame and channel must be in bounds relative to ksmps and nchnls.
	*/
	SetSpinSample :: proc(csound: ^CSOUND, frame: i32, channel: i32, sample: i32) ---

	/**
	* Returns the address of the Csound audio output working buffer (spout).
	* Enables external software to read audio from Csound after calling
	* csoundPerformKsmps.
	*/
	GetSpout :: proc(csound: ^CSOUND) -> ^i32 ---

	/**
	* Returns the indicated sample from the Csound audio output
	* working buffer (spout); only ever makes sense after calling
	* csoundPerformKsmps().  The frame and channel must be in bounds
	* relative to ksmps and nchnls.
	*/
	GetSpoutSample :: proc(csound: ^CSOUND, frame: i32, channel: i32) -> i32 ---

	/**
	* Return pointer to user data pointer for real time audio input.
	*/
	GetRtRecordUserData :: proc(^CSOUND) -> ^rawptr ---

	/**
	* Return pointer to user data pointer for real time audio output.
	*/
	GetRtPlayUserData :: proc(^CSOUND) -> ^rawptr ---

	/**
	* Calling this function with a non-zero 'state' value between
	* csoundCreate() and the start of performance will disable all default
	* handling of sound I/O by the Csound library, allowing the host
	* application to use the spin/spout/input/output buffers directly.
	* For applications using spin/spout, bufSize should be set to 0.
	* If 'bufSize' is greater than zero, the buffer size (-b) in frames will be
	* set to the integer multiple of ksmps that is nearest to the value
	* specified.
	*/
	SetHostImplementedAudioIO :: proc(_: ^CSOUND, state: i32, bufSize: i32) ---

	/**
	* This function can be called to obtain a list of available
	* input or output audio devices. If list is NULL, the function
	* will only return the number of devices (isOutput=1 for out
	* devices, 0 for in devices).
	* If list is non-NULL, then it should contain enough memory for
	* one CS_AUDIODEVICE structure per device.
	* Hosts will typically call this function twice: first to obtain
	* a number of devices, then, after allocating space for each
	* device information structure, pass an array of CS_AUDIODEVICE
	* structs to be filled:
	*
	* \code
	*   int i,n = csoundGetAudioDevList(csound,NULL,1);
	*   CS_AUDIODEVICE *devs = (CS_AUDIODEVICE *)
	*       malloc(n*sizeof(CS_AUDIODEVICE));
	*   csoundGetAudioDevList(csound,devs,1);
	*   for(i=0; i < n; i++)
	*       csound->Message(csound, " %d: %s (%s)\n",
	*             i, devs[i].device_id, devs[i].device_name);
	*   free(devs);
	* \endcode
	*/
	GetAudioDevList :: proc(csound: ^CSOUND, list: ^CS_AUDIODEVICE, isOutput: i32) -> i32 ---

	/**
	* Sets a function to be called by Csound for opening real-time
	* audio playback.
	*/
	SetPlayopenCallback :: proc(_: ^CSOUND, playopen__: proc "c" (_: ^CSOUND, parm: ^csRtAudioParams) -> i32) ---

	/**
	* Sets a function to be called by Csound for performing real-time
	* audio playback.
	*/
	SetRtplayCallback :: proc(_: ^CSOUND, rtplay__: proc "c" (_: ^CSOUND, outBuf: ^i32, nbytes: i32)) ---

	/**
	* Sets a function to be called by Csound for opening real-time
	* audio recording.
	*/
	SetRecopenCallback :: proc(_: ^CSOUND, recopen_: proc "c" (_: ^CSOUND, parm: ^csRtAudioParams) -> i32) ---

	/**
	* Sets a function to be called by Csound for performing real-time
	* audio recording.
	*/
	SetRtrecordCallback :: proc(_: ^CSOUND, rtrecord__: proc "c" (_: ^CSOUND, inBuf: ^i32, nbytes: i32) -> i32) ---

	/**
	* Sets a function to be called by Csound for closing real-time
	* audio playback and recording.
	*/
	SetRtcloseCallback :: proc(_: ^CSOUND, rtclose__: proc "c" (^CSOUND)) ---

	/**
	* Sets a function that is called to obtain a list of audio devices.
	* This should be set by rtaudio modules and should not be set by hosts.
	* (See csoundGetAudioDevList())
	*/
	SetAudioDeviceListCallback :: proc(csound: ^CSOUND, audiodevlist__: proc "c" (_: ^CSOUND, list: ^CS_AUDIODEVICE, isOutput: i32) -> i32) ---

	/**
	*  Sets the current MIDI IO module
	*/
	SetMIDIModule :: proc(csound: ^CSOUND, module: cstring) ---

	/**
	* call this function with state 1 if the host is implementing
	* MIDI via the callbacks below.
	*/
	SetHostImplementedMIDIIO :: proc(csound: ^CSOUND, state: i32) ---

	/**
	* This function can be called to obtain a list of available
	* input or output midi devices. If list is NULL, the function
	* will only return the number of devices (isOutput=1 for out
	* devices, 0 for in devices).
	* If list is non-NULL, then it should contain enough memory for
	* one CS_MIDIDEVICE structure per device.
	* Hosts will typically call this function twice: first to obtain
	* a number of devices, then, after allocating space for each
	* device information structure, pass an array of CS_MIDIDEVICE
	* structs to be filled. (see also csoundGetAudioDevList())
	*/
	GetMIDIDevList :: proc(csound: ^CSOUND, list: ^CS_MIDIDEVICE, isOutput: i32) -> i32 ---

	/**
	* Sets callback for opening real time MIDI input.
	*/
	SetExternalMidiInOpenCallback :: proc(_: ^CSOUND, func: proc "c" (_: ^CSOUND, userData: ^rawptr, devName: cstring) -> i32) ---

	/**
	* Sets callback for reading from real time MIDI input.
	*/
	SetExternalMidiReadCallback :: proc(_: ^CSOUND, func: proc "c" (_: ^CSOUND, userData: rawptr, buf: ^u8, nBytes: i32) -> i32) ---

	/**
	* Sets callback for closing real time MIDI input.
	*/
	SetExternalMidiInCloseCallback :: proc(_: ^CSOUND, func: proc "c" (_: ^CSOUND, userData: rawptr) -> i32) ---

	/**
	* Sets callback for opening real time MIDI output.
	*/
	SetExternalMidiOutOpenCallback :: proc(_: ^CSOUND, func: proc "c" (_: ^CSOUND, userData: ^rawptr, devName: cstring) -> i32) ---

	/**
	* Sets callback for writing to real time MIDI output.
	*/
	SetExternalMidiWriteCallback :: proc(_: ^CSOUND, func: proc "c" (_: ^CSOUND, userData: rawptr, buf: ^u8, nBytes: i32) -> i32) ---

	/**
	* Sets callback for closing real time MIDI output.
	*/
	SetExternalMidiOutCloseCallback :: proc(_: ^CSOUND, func: proc "c" (_: ^CSOUND, userData: rawptr) -> i32) ---

	/**
	* Sets callback for converting MIDI error codes to strings.
	*/
	SetExternalMidiErrorStringCallback :: proc(_: ^CSOUND, func: proc "c" (i32) -> cstring) ---

	/**
	* Sets a function that is called to obtain a list of MIDI devices.
	* This should be set by IO plugins, and should not be used by hosts.
	* (See csoundGetMIDIDevList())
	*/
	SetMIDIDeviceListCallback :: proc(csound: ^CSOUND, mididevlist__: proc "c" (_: ^CSOUND, list: ^CS_MIDIDEVICE, isOutput: i32) -> i32) ---

	/**
	*  Read, preprocess, and load a score from an ASCII string
	*  It can be called repeatedly, with the new score events
	*  being added to the currently scheduled ones.
	*/
	ReadScore :: proc(csound: ^CSOUND, str: cstring) -> i32 ---

	/**
	*  Asynchronous version of csoundReadScore().
	*/
	ReadScoreAsync :: proc(csound: ^CSOUND, str: cstring) ---

	/**
	* Returns the current score time in seconds
	* since the beginning of performance.
	*/
	GetScoreTime :: proc(^CSOUND) -> f64 ---

	/**
	* Sets whether Csound score events are performed or not, independently
	* of real-time MIDI events (see csoundSetScorePending()).
	*/
	IsScorePending :: proc(^CSOUND) -> i32 ---

	/**
	* Sets whether Csound score events are performed or not (real-time
	* events will continue to be performed). Can be used by external software,
	* such as a VST host, to turn off performance of score events (while
	* continuing to perform real-time events), for example to
	* mute a Csound score while working on other tracks of a piece, or
	* to play the Csound instruments live.
	*/
	SetScorePending :: proc(_: ^CSOUND, pending: i32) ---

	/**
	* Returns the score time beginning at which score events will
	* actually immediately be performed (see csoundSetScoreOffsetSeconds()).
	*/
	GetScoreOffsetSeconds :: proc(^CSOUND) -> i32 ---

	/**
	* Csound score events prior to the specified time are not performed, and
	* performance begins immediately at the specified time (real-time events
	* will continue to be performed as they are received).
	* Can be used by external software, such as a VST host,
	* to begin score performance midway through a Csound score,
	* for example to repeat a loop in a sequencer, or to synchronize
	* other events with the Csound score.
	*/
	SetScoreOffsetSeconds :: proc(_: ^CSOUND, time: i32) ---

	/**
	* Rewinds a compiled Csound score to the time specified with
	* csoundSetScoreOffsetSeconds().
	*/
	RewindScore :: proc(^CSOUND) ---

	/**
	* Sets an external callback for Cscore processing.
	* Pass NULL to reset to the internal cscore() function
	* (which does nothing).
	* This callback is retained after a csoundReset() call.
	*/
	SetCscoreCallback :: proc(_: ^CSOUND, cscoreCallback_: proc "c" (^CSOUND)) ---

	/**
	* Sorts score file 'inFile' and writes the result to 'outFile'.
	* The Csound instance should be initialised
	* before calling this function, and csoundReset() should be called
	* after sorting the score to clean up. On success, zero is returned.
	*/
	ScoreSort :: proc(_: ^CSOUND, inFile: ^FILE, outFile: ^FILE) -> i32 ---

	/**
	* Extracts from 'inFile', controlled by 'extractFile', and writes
	* the result to 'outFile'. The Csound instance should be initialised
	* before calling this function, and csoundReset()
	* should be called after score extraction to clean up.
	* The return value is zero on success.
	*/
	ScoreExtract :: proc(_: ^CSOUND, inFile: ^FILE, outFile: ^FILE, extractFile: ^FILE) -> i32 ---

	/**
	* Displays an informational message.
	*/
	Message :: proc(_: ^CSOUND, format: cstring, #c_vararg _: ..any) -> i32 ---

	/**
	* Print message with special attributes (see msg_attr.h for the list of
	* available attributes). With attr=0, csoundMessageS() is identical to
	* csoundMessage().
	*/
	MessageS                  :: proc(_: ^CSOUND, attr: i32, format: cstring, #c_vararg _: ..any) -> i32 ---
	MessageV                  :: proc(_: ^CSOUND, attr: i32, format: cstring, args: c.va_list) ---
	SetDefaultMessageCallback :: proc(csoundMessageCallback_: proc "c" (_: ^CSOUND, attr: i32, format: cstring, valist: c.va_list)) ---

	/**
	* Sets a function to be called by Csound to print an informational message.
	* This callback is never called on --realtime mode
	*/
	SetMessageCallback :: proc(_: ^CSOUND, csoundMessageCallback_: proc "c" (_: ^CSOUND, attr: i32, format: cstring, valist: c.va_list)) ---

	/**
	* Sets an alternative function to be called by Csound to print an
	* informational message, using a less granular signature.
	*  This callback can be set for --realtime mode.
	*  This callback is cleared after csoundReset
	*/
	SetMessageStringCallback :: proc(csound: ^CSOUND, csoundMessageStrCallback: proc "c" (csound: ^CSOUND, attr: i32, str: cstring)) ---

	/**
	* Returns the Csound message level (from 0 to 231).
	*/
	GetMessageLevel :: proc(^CSOUND) -> i32 ---

	/**
	* Sets the Csound message level (from 0 to 231).
	*/
	SetMessageLevel :: proc(_: ^CSOUND, messageLevel: i32) ---

	/**
	* Creates a buffer for storing messages printed by Csound.
	* Should be called after creating a Csound instance andthe buffer
	* can be freed by calling csoundDestroyMessageBuffer() before
	* deleting the Csound instance. You will generally want to call
	* csoundCleanup() to make sure the last messages are flushed to
	* the message buffer before destroying Csound.
	* If 'toStdOut' is non-zero, the messages are also printed to
	* stdout and stderr (depending on the type of the message),
	* in addition to being stored in the buffer.
	* Using the message buffer ties up the internal message callback, so
	* csoundSetMessageCallback should not be called after creating the
	* message buffer.
	*/
	CreateMessageBuffer :: proc(csound: ^CSOUND, toStdOut: i32) ---

	/**
	* Returns the first message from the buffer.
	*/
	GetFirstMessage :: proc(csound: ^CSOUND) -> cstring ---

	/**
	* Returns the attribute parameter (see msg_attr.h) of the first message
	* in the buffer.
	*/
	GetFirstMessageAttr :: proc(csound: ^CSOUND) -> i32 ---

	/**
	* Removes the first message from the buffer.
	*/
	PopFirstMessage :: proc(csound: ^CSOUND) ---

	/**
	* Returns the number of pending messages in the buffer.
	*/
	GetMessageCnt :: proc(csound: ^CSOUND) -> i32 ---

	/**
	* Releases all memory used by the message buffer.
	*/
	DestroyMessageBuffer :: proc(csound: ^CSOUND) ---

	/**
	* Stores a pointer to the specified channel of the bus in *p,
	* creating the channel first if it does not exist yet.
	* 'type' must be the bitwise OR of exactly one of the following values,
	*   CSOUND_CONTROL_CHANNEL
	*     control data (one MYFLT value)
	*   CSOUND_AUDIO_CHANNEL
	*     audio data (csoundGetKsmps(csound) MYFLT values)
	*   CSOUND_STRING_CHANNEL
	*     string data (MYFLT values with enough space to store
	*     csoundGetChannelDatasize() characters, including the
	*     NULL character at the end of the string)
	* and at least one of these:
	*   CSOUND_INPUT_CHANNEL
	*   CSOUND_OUTPUT_CHANNEL
	* If the channel already exists, it must match the data type
	* (control, audio, or string), however, the input/output bits are
	* OR'd with the new value. Note that audio and string channels
	* can only be created after calling csoundCompile(), because the
	* storage size is not known until then.
	
	* Return value is zero on success, or a negative error code,
	*   CSOUND_MEMORY  there is not enough memory for allocating the channel
	*   CSOUND_ERROR   the specified name or type is invalid
	* or, if a channel with the same name but incompatible type
	* already exists, the type of the existing channel. In the case
	* of any non-zero return value, *p is set to NULL.
	* Note: to find out the type of a channel without actually
	* creating or changing it, set 'type' to zero, so that the return
	* value will be either the type of the channel, or CSOUND_ERROR
	* if it does not exist.
	*
	* Operations on **p are not thread-safe by default. The host is required
	* to take care of threadsafety by
	* 1) with control channels use __atomic_load() or
	*    __atomic_store() gcc atomic builtins to get or set a channel,
	*    if available.
	* 2) For string and audio channels (and controls if option 1 is not
	*    available), retrieve the channel lock with csoundGetChannelLock()
	*    and use csoundSpinLock() and csoundSpinUnLock() to protect access
	*    to **p.
	* See Top/threadsafe.c in the Csound library sources for
	* examples.  Optionally, use the channel get/set functions
	* provided below, which are threadsafe by default.
	*/
	GetChannelPtr :: proc(_: ^CSOUND, p: ^^i32, name: cstring, type: i32) -> i32 ---

	/**
	* Returns a list of allocated channels in *lst. A controlChannelInfo_t
	* structure contains the channel characteristics.
	* The return value is the number of channels, which may be zero if there
	* are none, or CSOUND_MEMORY if there is not enough memory for allocating
	* the list. In the case of no channels or an error, *lst is set to NULL.
	* Notes: the caller is responsible for freeing the list returned in *lst
	* with csoundDeleteChannelList(). The name pointers may become invalid
	* after calling csoundReset().
	*/
	ListChannels :: proc(_: ^CSOUND, lst: ^^controlChannelInfo_t) -> i32 ---

	/**
	* Releases a channel list previously returned by csoundListChannels().
	*/
	DeleteChannelList :: proc(_: ^CSOUND, lst: ^controlChannelInfo_t) ---

	/**
	* Set parameters hints for a control channel. These hints have no internal
	* function but can be used by front ends to construct GUIs or to constrain
	* values. See the controlChannelHints_t structure for details.
	* Returns zero on success, or a non-zero error code on failure:
	*   CSOUND_ERROR:  the channel does not exist, is not a control channel,
	*                  or the specified parameters are invalid
	*   CSOUND_MEMORY: could not allocate memory
	*/
	SetControlChannelHints :: proc(_: ^CSOUND, name: cstring, hints: controlChannelHints_t) -> i32 ---

	/**
	* Returns special parameters (assuming there are any) of a control channel,
	* previously set with csoundSetControlChannelHints() or the chnparams
	* opcode.
	* If the channel exists, is a control channel, the channel hints
	* are stored in the preallocated controlChannelHints_t structure. The
	* attributes member of the structure will be allocated inside this function
	* so it is necessary to free it explicitly in the host.
	*
	* The return value is zero if the channel exists and is a control
	* channel, otherwise, an error code is returned.
	*/
	GetControlChannelHints :: proc(_: ^CSOUND, name: cstring, hints: ^controlChannelHints_t) -> i32 ---

	/**
	* Recovers a pointer to a lock for the specified channel called 'name'.
	* The returned lock can be locked/unlocked  with the csoundSpinLock()
	* and csoundSpinUnLock() functions.
	* @returns the address of the lock or NULL if the channel does not exist
	*/
	GetChannelLock :: proc(_: ^CSOUND, name: cstring) -> ^i32 ---

	/**
	* retrieves the value of control channel identified by *name.
	* If the err argument is not NULL, the error (or success) code
	* finding or accessing the channel is stored in it.
	*/
	GetControlChannel :: proc(csound: ^CSOUND, name: cstring, err: ^i32) -> i32 ---

	/**
	* sets the value of control channel identified by *name
	*/
	SetControlChannel :: proc(csound: ^CSOUND, name: cstring, val: i32) ---

	/**
	* copies the audio channel identified by *name into array
	* *samples which should contain enough memory for ksmps MYFLTs
	*/
	GetAudioChannel :: proc(csound: ^CSOUND, name: cstring, samples: ^i32) ---

	/**
	* sets the audio channel identified by *name with data from array
	* *samples which should contain at least ksmps MYFLTs
	*/
	SetAudioChannel :: proc(csound: ^CSOUND, name: cstring, samples: ^i32) ---

	/**
	* copies the string channel identified by *name into *string
	* which should contain enough memory for the string
	* (see csoundGetChannelDatasize() below)
	*/
	GetStringChannel :: proc(csound: ^CSOUND, name: cstring, _string: cstring) ---

	/**
	* sets the string channel identified by *name with *string
	*/
	SetStringChannel :: proc(csound: ^CSOUND, name: cstring, _string: cstring) ---

	/**
	* returns the size of data stored in a channel; for string channels
	* this might change if the channel space gets reallocated
	* Since string variables use dynamic memory allocation in Csound6,
	* this function can be called to get the space required for
	* csoundGetStringChannel()
	*/
	GetChannelDatasize :: proc(csound: ^CSOUND, name: cstring) -> i32 ---

	/** Sets the function which will be called whenever the invalue opcode
	* is used. */
	SetInputChannelCallback :: proc(csound: ^CSOUND, inputChannelCalback: channelCallback_t) ---

	/** Sets the function which will be called whenever the outvalue opcode
	* is used. */
	SetOutputChannelCallback :: proc(csound: ^CSOUND, outputChannelCalback: channelCallback_t) ---

	/**
	* Sends a PVSDATEX fin to the pvsin opcode (f-rate) for channel 'name'.
	* Returns zero on success, CSOUND_ERROR if the index is invalid or
	* fsig framesizes are incompatible.
	* CSOUND_MEMORY if there is not enough memory to extend the bus.
	*/
	SetPvsChannel :: proc(_: ^CSOUND, fin: ^PVSDATEXT, name: cstring) -> i32 ---

	/**
	* Receives a PVSDAT fout from the pvsout opcode (f-rate) at channel 'name'
	* Returns zero on success, CSOUND_ERROR if the index is invalid or
	* if fsig framesizes are incompatible.
	* CSOUND_MEMORY if there is not enough memory to extend the bus
	*/
	GetPvsChannel :: proc(csound: ^CSOUND, fout: ^PVSDATEXT, name: cstring) -> i32 ---

	/**
	* Send a new score event. 'type' is the score event type ('a', 'i', 'q',
	* 'f', or 'e').
	* 'numFields' is the size of the pFields array.  'pFields' is an array of
	* floats with all the pfields for this event, starting with the p1 value
	* specified in pFields[0].
	*/
	ScoreEvent :: proc(_: ^CSOUND, type: i8, pFields: ^i32, numFields: c.long) -> i32 ---

	/**
	*  Asynchronous version of csoundScoreEvent().
	*/
	ScoreEventAsync :: proc(_: ^CSOUND, type: i8, pFields: ^i32, numFields: c.long) ---

	/**
	* Like csoundScoreEvent(), this function inserts a score event, but
	* at absolute time with respect to the start of performance, or from an
	* offset set with time_ofs
	*/
	ScoreEventAbsolute :: proc(_: ^CSOUND, type: i8, pfields: ^i32, numFields: c.long, time_ofs: f64) -> i32 ---

	/**
	*  Asynchronous version of csoundScoreEventAbsolute().
	*/
	ScoreEventAbsoluteAsync :: proc(_: ^CSOUND, type: i8, pfields: ^i32, numFields: c.long, time_ofs: f64) ---

	/**
	* Input a NULL-terminated string (as if from a console),
	* used for line events.
	*/
	InputMessage :: proc(_: ^CSOUND, message: cstring) ---

	/**
	* Asynchronous version of csoundInputMessage().
	*/
	InputMessageAsync :: proc(_: ^CSOUND, message: cstring) ---

	/**
	* Kills off one or more running instances of an instrument identified
	* by instr (number) or instrName (name). If instrName is NULL, the
	* instrument number is used.
	* Mode is a sum of the following values:
	* 0,1,2: kill all instances (1), oldest only (1), or newest (2)
	* 4: only turnoff notes with exactly matching (fractional) instr number
	* 8: only turnoff notes with indefinite duration (p3 < 0 or MIDI)
	* allow_release, if non-zero, the killed instances are allowed to release.
	*/
	KillInstance :: proc(csound: ^CSOUND, instr: i32, instrName: cstring, mode: i32, allow_release: i32) -> i32 ---

	/**
	* Register a function to be called once in every control period
	* by sensevents(). Any number of functions may be registered,
	* and will be called in the order of registration.
	* The callback function takes two arguments: the Csound instance
	* pointer, and the userData pointer as passed to this function.
	* This facility can be used to ensure a function is called synchronously
	* before every csound control buffer processing. It is important
	* to make sure no blocking operations are performed in the callback.
	* The callbacks are cleared on csoundCleanup().
	* Returns zero on success.
	*/
	RegisterSenseEventCallback :: proc(_: ^CSOUND, func: proc "c" (^CSOUND, rawptr), userData: rawptr) -> i32 ---

	/**
	* Set the ASCII code of the most recent key pressed.
	* This value is used by the 'sensekey' opcode if a callback
	* for returning keyboard events is not set (see
	* csoundRegisterKeyboardCallback()).
	*/
	KeyPress :: proc(_: ^CSOUND, _c: i8) ---

	/**
	* Registers general purpose callback functions that will be called to query
	* keyboard events. These callbacks are called on every control period by
	* the sensekey opcode.
	* The callback is preserved on csoundReset(), and multiple
	* callbacks may be set and will be called in reverse order of
	* registration. If the same function is set again, it is only moved
	* in the list of callbacks so that it will be called first, and the
	* user data and type mask parameters are updated. 'typeMask' can be the
	* bitwise OR of callback types for which the function should be called,
	* or zero for all types.
	* Returns zero on success, CSOUND_ERROR if the specified function
	* pointer or type mask is invalid, and CSOUND_MEMORY if there is not
	* enough memory.
	*
	* The callback function takes the following arguments:
	*   void *userData
	*     the "user data" pointer, as specified when setting the callback
	*   void *p
	*     data pointer, depending on the callback type
	*   unsigned int type
	*     callback type, can be one of the following (more may be added in
	*     future versions of Csound):
	*       CSOUND_CALLBACK_KBD_EVENT
	*       CSOUND_CALLBACK_KBD_TEXT
	*         called by the sensekey opcode to fetch key codes. The data
	*         pointer is a pointer to a single value of type 'int', for
	*         returning the key code, which can be in the range 1 to 65535,
	*         or 0 if there is no keyboard event.
	*         For CSOUND_CALLBACK_KBD_EVENT, both key press and release
	*         events should be returned (with 65536 (0x10000) added to the
	*         key code in the latter case) as unshifted ASCII codes.
	*         CSOUND_CALLBACK_KBD_TEXT expects key press events only as the
	*         actual text that is typed.
	* The return value should be zero on success, negative on error, and
	* positive if the callback was ignored (for example because the type is
	* not known).
	*/
	RegisterKeyboardCallback :: proc(_: ^CSOUND, func: proc "c" (userData: rawptr, p: rawptr, type: u32) -> i32, userData: rawptr, type: u32) -> i32 ---

	/**
	* Removes a callback previously set with csoundRegisterKeyboardCallback().
	*/
	RemoveKeyboardCallback :: proc(csound: ^CSOUND, func: proc "c" (rawptr, rawptr, u32) -> i32) ---

	/** @}*/
	/** @defgroup TABLE Tables
	*
	*  @{ */
	/**
	* Returns the length of a function table (not including the guard point),
	* or -1 if the table does not exist.
	*/
	TableLength :: proc(_: ^CSOUND, table: i32) -> i32 ---

	/**
	* Returns the value of a slot in a function table.
	* The table number and index are assumed to be valid.
	*/
	TableGet :: proc(_: ^CSOUND, table: i32, index: i32) -> i32 ---

	/**
	* Sets the value of a slot in a function table.
	* The table number and index are assumed to be valid.
	*/
	TableSet :: proc(_: ^CSOUND, table: i32, index: i32, value: i32) ---

	/**
	* Copy the contents of a function table into a supplied array *dest
	* The table number is assumed to be valid, and the destination needs to
	* have sufficient space to receive all the function table contents.
	*/
	TableCopyOut :: proc(csound: ^CSOUND, table: i32, dest: ^i32) ---

	/**
	* Asynchronous version of csoundTableCopyOut()
	*/
	TableCopyOutAsync :: proc(csound: ^CSOUND, table: i32, dest: ^i32) ---

	/**
	* Copy the contents of an array *src into a given function table
	* The table number is assumed to be valid, and the table needs to
	* have sufficient space to receive all the array contents.
	*/
	TableCopyIn :: proc(csound: ^CSOUND, table: i32, src: ^i32) ---

	/**
	* Asynchronous version of csoundTableCopyIn()
	*/
	TableCopyInAsync :: proc(csound: ^CSOUND, table: i32, src: ^i32) ---

	/**
	* Stores pointer to function table 'tableNum' in *tablePtr,
	* and returns the table length (not including the guard point).
	* If the table does not exist, *tablePtr is set to NULL and
	* -1 is returned.
	*/
	GetTable :: proc(_: ^CSOUND, tablePtr: ^^i32, tableNum: i32) -> i32 ---

	/**
	* Stores pointer to the arguments used to generate
	* function table 'tableNum' in *argsPtr,
	* and returns the number of arguments used.
	* If the table does not exist, *argsPtr is set to NULL and
	* -1 is returned.
	* NB: the argument list starts with the GEN number and is followed by
	* its parameters. eg. f 1 0 1024 10 1 0.5  yields the list {10.0,1.0,0.5}
	*/
	GetTableArgs :: proc(csound: ^CSOUND, argsPtr: ^^i32, tableNum: i32) -> i32 ---

	/**
	* Checks if a given GEN number num is a named GEN
	* if so, it returns the string length (excluding terminating NULL char)
	* Otherwise it returns 0.
	*/
	IsNamedGEN :: proc(csound: ^CSOUND, num: i32) -> i32 ---

	/**
	* Gets the GEN name from a number num, if this is a named GEN
	* The final parameter is the max len of the string (excluding termination)
	*/
	GetNamedGEN :: proc(csound: ^CSOUND, num: i32, name: cstring, len: i32) ---

	/** @}*/
	/** @defgroup TABLEDISPLAY Function table display
	*
	*  @{ */
	/**
	* Tells Csound whether external graphic table display is supported.
	* Returns the previously set value (initially zero).
	*/
	SetIsGraphable :: proc(_: ^CSOUND, isGraphable: i32) -> i32 ---

	/**
	* Called by external software to set Csound's MakeGraph function.
	*/
	SetMakeGraphCallback :: proc(_: ^CSOUND, makeGraphCallback_: proc "c" (_: ^CSOUND, windat: ^WINDAT, name: cstring)) ---

	/**
	* Called by external software to set Csound's DrawGraph function.
	*/
	SetDrawGraphCallback :: proc(_: ^CSOUND, drawGraphCallback_: proc "c" (_: ^CSOUND, windat: ^WINDAT)) ---

	/**
	* Called by external software to set Csound's KillGraph function.
	*/
	SetKillGraphCallback :: proc(_: ^CSOUND, killGraphCallback_: proc "c" (_: ^CSOUND, windat: ^WINDAT)) ---

	/**
	* Called by external software to set Csound's ExitGraph function.
	*/
	SetExitGraphCallback :: proc(_: ^CSOUND, exitGraphCallback_: proc "c" (^CSOUND) -> i32) ---

	/**
	* Finds the list of named gens
	*/
	GetNamedGens :: proc(^CSOUND) -> rawptr ---

	/**
	* Gets an alphabetically sorted list of all opcodes.
	* Should be called after externals are loaded by csoundCompile().
	* Returns the number of opcodes, or a negative error code on failure.
	* Make sure to call csoundDisposeOpcodeList() when done with the list.
	*/
	NewOpcodeList :: proc(_: ^CSOUND, opcodelist: ^^opcodeListEntry) -> i32 ---

	/**
	* Releases an opcode list.
	*/
	DisposeOpcodeList :: proc(_: ^CSOUND, opcodelist: ^opcodeListEntry) ---

	/**
	* Appends an opcode implemented by external software
	* to Csound's internal opcode list.
	* The opcode list is extended by one slot,
	* and the parameters are copied into the new slot.
	* Returns zero on success.
	*/
	AppendOpcode :: proc(_: ^CSOUND, opname: cstring, dsblksiz: i32, flags: i32, thread: i32, outypes: cstring, intypes: cstring, iopadr: proc "c" (^CSOUND, rawptr) -> i32, kopadr: proc "c" (^CSOUND, rawptr) -> i32, aopadr: proc "c" (^CSOUND, rawptr) -> i32) -> i32 ---

	/**
	* Called by external software to set a function for checking system
	* events, yielding cpu time for coopertative multitasking, etc.
	* This function is optional. It is often used as a way to 'turn off'
	* Csound, allowing it to exit gracefully. In addition, some operations
	* like utility analysis routines are not reentrant and you should use
	* this function to do any kind of updating during the operation.
	* Returns an 'OK to continue' boolean.
	*/
	SetYieldCallback :: proc(_: ^CSOUND, yieldCallback_: proc "c" (^CSOUND) -> i32) ---

	/**
	* Creates and starts a new thread of execution.
	* Returns an opaque pointer that represents the thread on success,
	* or NULL for failure.
	* The userdata pointer is passed to the thread routine.
	*/
	CreateThread :: proc(threadRoutine: proc "c" (rawptr) -> c.uintptr_t, userdata: rawptr) -> rawptr ---

	/**
	* Creates and starts a new thread of execution
	* with a user-defined stack size.
	* Returns an opaque pointer that represents the thread on success,
	* or NULL for failure.
	* The userdata pointer is passed to the thread routine.
	*/
	CreateThread2 :: proc(threadRoutine: proc "c" (rawptr) -> c.uintptr_t, stack: u32, userdata: rawptr) -> rawptr ---

	/**
	* Returns the ID of the currently executing thread,
	* or NULL for failure.
	*
	* NOTE: The return value can be used as a pointer
	* to a thread object, but it should not be compared
	* as a pointer. The pointed to values should be compared,
	* and the user must free the pointer after use.
	*/
	GetCurrentThreadId :: proc() -> rawptr ---

	/**
	* Waits until the indicated thread's routine has finished.
	* Returns the value returned by the thread routine.
	*/
	JoinThread :: proc(thread: rawptr) -> c.uintptr_t ---

	/**
	* Creates and returns a monitor object, or NULL if not successful.
	* The object is initially in signaled (notified) state.
	*/
	CreateThreadLock :: proc() -> rawptr ---

	/**
	* Waits on the indicated monitor object for the indicated period.
	* The function returns either when the monitor object is notified,
	* or when the period has elapsed, whichever is sooner; in the first case,
	* zero is returned.
	* If 'milliseconds' is zero and the object is not notified, the function
	* will return immediately with a non-zero status.
	*/
	WaitThreadLock :: proc(lock: rawptr, milliseconds: c.size_t) -> i32 ---

	/**
	* Waits on the indicated monitor object until it is notified.
	* This function is similar to csoundWaitThreadLock() with an infinite
	* wait time, but may be more efficient.
	*/
	WaitThreadLockNoTimeout :: proc(lock: rawptr) ---

	/**
	* Notifies the indicated monitor object.
	*/
	NotifyThreadLock :: proc(lock: rawptr) ---

	/**
	* Destroys the indicated monitor object.
	*/
	DestroyThreadLock :: proc(lock: rawptr) ---

	/**
	* Creates and returns a mutex object, or NULL if not successful.
	* Mutexes can be faster than the more general purpose monitor objects
	* returned by csoundCreateThreadLock() on some platforms, and can also
	* be recursive, but the result of unlocking a mutex that is owned by
	* another thread or is not locked is undefined.
	* If 'isRecursive' is non-zero, the mutex can be re-locked multiple
	* times by the same thread, requiring an equal number of unlock calls;
	* otherwise, attempting to re-lock the mutex results in undefined
	* behavior.
	* Note: the handles returned by csoundCreateThreadLock() and
	* csoundCreateMutex() are not compatible.
	*/
	CreateMutex :: proc(isRecursive: i32) -> rawptr ---

	/**
	* Acquires the indicated mutex object; if it is already in use by
	* another thread, the function waits until the mutex is released by
	* the other thread.
	*/
	LockMutex :: proc(mutex_: rawptr) ---

	/**
	* Acquires the indicated mutex object and returns zero, unless it is
	* already in use by another thread, in which case a non-zero value is
	* returned immediately, rather than waiting until the mutex becomes
	* available.
	* Note: this function may be unimplemented on Windows.
	*/
	LockMutexNoWait :: proc(mutex_: rawptr) -> i32 ---

	/**
	* Releases the indicated mutex object, which should be owned by
	* the current thread, otherwise the operation of this function is
	* undefined. A recursive mutex needs to be unlocked as many times
	* as it was locked previously.
	*/
	UnlockMutex :: proc(mutex_: rawptr) ---

	/**
	* Destroys the indicated mutex object. Destroying a mutex that
	* is currently owned by a thread results in undefined behavior.
	*/
	DestroyMutex :: proc(mutex_: rawptr) ---

	/**
	* Create a Thread Barrier. Max value parameter should be equal to
	* number of child threads using the barrier plus one for the
	* master thread */
	CreateBarrier :: proc(max: u32) -> rawptr ---

	/**
	* Destroy a Thread Barrier.
	*/
	DestroyBarrier :: proc(barrier: rawptr) -> i32 ---

	/**
	* Wait on the thread barrier.
	*/
	WaitBarrier :: proc(barrier: rawptr) -> i32 ---

	/** Creates a conditional variable */
	CreateCondVar :: proc() -> rawptr ---

	/** Waits up on a conditional variable and mutex */
	CondWait :: proc(condVar: rawptr, mutex: rawptr) ---

	/** Signals a conditional variable */
	CondSignal :: proc(condVar: rawptr) ---

	/** Destroys a conditional variable */
	DestroyCondVar :: proc(condVar: rawptr) ---

	/**
	* Waits for at least the specified number of milliseconds,
	* yielding the CPU to other threads.
	*/
	Sleep :: proc(milliseconds: c.size_t) ---

	/**
	* If the spinlock is not locked, lock it and return;
	* if is is locked, wait until it is unlocked, then lock it and return.
	* Uses atomic compare and swap operations that are safe across processors
	* and safe for out of order operations,
	* and which are more efficient than operating system locks.
	* Use spinlocks to protect access to shared data, especially in functions
	* that do little more than read or write such data, for example:
	*
	* @code
	* static spin_lock_t lock = SPINLOCK_INIT;
	* csoundSpinLockInit(&lock);
	* void write(size_t frames, int* signal)
	* {
	*   csoundSpinLock(&lock);
	*   for (size_t frame = 0; i < frames; frame++) {
	*     global_buffer[frame] += signal[frame];
	*   }
	*   csoundSpinUnlock(&lock);
	* }
	* @endcode
	*/
	SpinLockInit :: proc(spinlock: ^i32) -> i32 ---

	/**
	* Locks the spinlock
	*/
	SpinLock :: proc(spinlock: ^i32) ---

	/**
	* Tries the lock, returns CSOUND_SUCCESS if lock could be acquired,
	CSOUND_ERROR, otherwise.
	*/
	SpinTryLock :: proc(spinlock: ^i32) -> i32 ---

	/**
	* Unlocks the spinlock
	*/
	SpinUnLock :: proc(spinlock: ^i32) ---

	/**
	* Runs an external command with the arguments specified in 'argv'.
	* argv[0] is the name of the program to execute (if not a full path
	* file name, it is searched in the directories defined by the PATH
	* environment variable). The list of arguments should be terminated
	* by a NULL pointer.
	* If 'noWait' is zero, the function waits until the external program
	* finishes, otherwise it returns immediately. In the first case, a
	* non-negative return value is the exit status of the command (0 to
	* 255), otherwise it is the PID of the newly created process.
	* On error, a negative value is returned.
	*/
	RunCommand :: proc(argv: ^cstring, noWait: i32) -> c.long ---

	/**
	* Initialise a timer structure.
	*/
	InitTimerStruct :: proc(^RTCLOCK) ---

	/**
	* Return the elapsed real time (in seconds) since the specified timer
	* structure was initialised.
	*/
	GetRealTime :: proc(^RTCLOCK) -> f64 ---

	/**
	* Return the elapsed CPU time (in seconds) since the specified timer
	* structure was initialised.
	*/
	GetCPUTime :: proc(^RTCLOCK) -> f64 ---

	/**
	* Return a 32-bit unsigned integer to be used as seed from current time.
	*/
	GetRandomSeedFromTime :: proc() -> i32 ---

	/**
	* Set language to 'lang_code' (lang_code can be for example
	* CSLANGUAGE_ENGLISH_UK or CSLANGUAGE_FRENCH or many others,
	* see n_getstr.h for the list of languages). This affects all
	* Csound instances running in the address space of the current
	* process. The special language code CSLANGUAGE_DEFAULT can be
	* used to disable translation of messages and free all memory
	* allocated by a previous call to csoundSetLanguage().
	* csoundSetLanguage() loads all files for the selected language
	* from the directory specified by the CSSTRNGS environment
	* variable.
	*/
	SetLanguage :: proc(lang_code: i32) ---

	/**
	* Get pointer to the value of environment variable 'name', searching
	* in this order: local environment of 'csound' (if not NULL), variables
	* set with csoundSetGlobalEnv(), and system environment variables.
	* If 'csound' is not NULL, should be called after csoundCompile().
	* Return value is NULL if the variable is not set.
	*/
	GetEnv :: proc(csound: ^CSOUND, name: cstring) -> cstring ---

	/**
	* Set the global value of environment variable 'name' to 'value',
	* or delete variable if 'value' is NULL.
	* It is not safe to call this function while any Csound instances
	* are active.
	* Returns zero on success.
	*/
	SetGlobalEnv :: proc(name: cstring, value: cstring) -> i32 ---

	/**
	* Allocate nbytes bytes of memory that can be accessed later by calling
	* csoundQueryGlobalVariable() with the specified name; the space is
	* cleared to zero.
	* Returns CSOUND_SUCCESS on success, CSOUND_ERROR in case of invalid
	* parameters (zero nbytes, invalid or already used name), or
	* CSOUND_MEMORY if there is not enough memory.
	*/
	CreateGlobalVariable :: proc(_: ^CSOUND, name: cstring, nbytes: c.size_t) -> i32 ---

	/**
	* Get pointer to space allocated with the name "name".
	* Returns NULL if the specified name is not defined.
	*/
	QueryGlobalVariable :: proc(_: ^CSOUND, name: cstring) -> rawptr ---

	/**
	* This function is the same as csoundQueryGlobalVariable(), except the
	* variable is assumed to exist and no error checking is done.
	* Faster, but may crash or return an invalid pointer if 'name' is
	* not defined.
	*/
	QueryGlobalVariableNoCheck :: proc(_: ^CSOUND, name: cstring) -> rawptr ---

	/**
	* Free memory allocated for "name" and remove "name" from the database.
	* Return value is CSOUND_SUCCESS on success, or CSOUND_ERROR if the name is
	* not defined.
	*/
	DestroyGlobalVariable :: proc(_: ^CSOUND, name: cstring) -> i32 ---

	/**
	* Run utility with the specified name and command line arguments.
	* Should be called after loading utility plugins.
	* Use csoundReset() to clean up after calling this function.
	* Returns zero if the utility was run successfully.
	*/
	RunUtility :: proc(_: ^CSOUND, name: cstring, argc: i32, argv: ^cstring) -> i32 ---

	/**
	* Returns a NULL terminated list of registered utility names.
	* The caller is responsible for freeing the returned array with
	* csoundDeleteUtilityList(), however, the names should not be
	* changed or freed.
	* The return value may be NULL in case of an error.
	*/
	ListUtilities :: proc(^CSOUND) -> ^cstring ---

	/**
	* Releases an utility list previously returned by csoundListUtilities().
	*/
	DeleteUtilityList :: proc(_: ^CSOUND, lst: ^cstring) ---

	/**
	* Get utility description.
	* Returns NULL if the utility was not found, or it has no description,
	* or an error occured.
	*/
	GetUtilityDescription :: proc(_: ^CSOUND, utilName: cstring) -> cstring ---

	/**
	* Simple linear congruential random number generator:
	*   (*seedVal) = (*seedVal) * 742938285 % 2147483647
	* the initial value of *seedVal must be in the range 1 to 2147483646.
	* Returns the next number from the pseudo-random sequence,
	* in the range 1 to 2147483646.
	*/
	Rand31 :: proc(seedVal: ^i32) -> i32 ---

	/**
	* Initialise Mersenne Twister (MT19937) random number generator,
	* using 'keyLength' unsigned 32 bit values from 'initKey' as seed.
	* If the array is NULL, the length parameter is used for seeding.
	*/
	SeedRandMT :: proc(p: ^CsoundRandMTState, initKey: ^i32, keyLength: i32) ---

	/**
	* Returns next random number from MT19937 generator.
	* The PRNG must be initialised first by calling csoundSeedRandMT().
	*/
	RandMT :: proc(p: ^CsoundRandMTState) -> i32 ---

	/**
	* Create circular buffer with numelem number of elements. The
	* element's size is set from elemsize. It should be used like:
	*@code
	* void *rb = csoundCreateCircularBuffer(csound, 1024, sizeof(MYFLT));
	*@endcode
	*/
	CreateCircularBuffer :: proc(csound: ^CSOUND, numelem: i32, elemsize: i32) -> rawptr ---

	/**
	* Read from circular buffer
	* @param csound This value is currently ignored.
	* @param circular_buffer pointer to an existing circular buffer
	* @param out preallocated buffer with at least items number of elements, where
	*              buffer contents will be read into
	* @param items number of samples to be read
	* @returns the actual number of items read (0 <= n <= items)
	*/
	ReadCircularBuffer :: proc(csound: ^CSOUND, circular_buffer: rawptr, out: rawptr, items: i32) -> i32 ---

	/**
	* Read from circular buffer without removing them from the buffer.
	* @param circular_buffer pointer to an existing circular buffer
	* @param out preallocated buffer with at least items number of elements, where
	*              buffer contents will be read into
	* @param items number of samples to be read
	* @returns the actual number of items read (0 <= n <= items)
	*/
	PeekCircularBuffer :: proc(csound: ^CSOUND, circular_buffer: rawptr, out: rawptr, items: i32) -> i32 ---

	/**
	* Write to circular buffer
	* @param csound This value is currently ignored.
	* @param p pointer to an existing circular buffer
	* @param inp buffer with at least items number of elements to be written into
	*              circular buffer
	* @param items number of samples to write
	* @returns the actual number of items written (0 <= n <= items)
	*/
	WriteCircularBuffer :: proc(csound: ^CSOUND, p: rawptr, inp: rawptr, items: i32) -> i32 ---

	/**
	* Empty circular buffer of any remaining data. This function should only be
	* used if there is no reader actively getting data from the buffer.
	* @param csound This value is currently ignored.
	* @param p pointer to an existing circular buffer
	*/
	FlushCircularBuffer :: proc(csound: ^CSOUND, p: rawptr) ---

	/**
	* Free circular buffer
	*/
	DestroyCircularBuffer :: proc(csound: ^CSOUND, circularbuffer: rawptr) ---

	/**
	* Platform-independent function to load a shared library.
	*/
	OpenLibrary :: proc(library: ^rawptr, libraryPath: cstring) -> i32 ---

	/**
	* Platform-independent function to unload a shared library.
	*/
	CloseLibrary :: proc(library: rawptr) -> i32 ---

	/**
	* Platform-independent function to get a symbol address in a shared library.
	*/
	GetLibrarySymbol :: proc(library: rawptr, symbolName: cstring) -> rawptr ---
}

FILE :: struct {}