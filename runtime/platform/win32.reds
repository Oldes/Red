Red/System [
	Title:   "Red runtime win32 API imported functions definitions"
	Author:  "Nenad Rakocevic"
	File: 	 %win32.reds
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2012 Nenad Rakocevic. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/dockimbel/Red/blob/master/red-system/runtime/BSL-License.txt
	}
]

#define VA_COMMIT_RESERVE	3000h						;-- MEM_COMMIT | MEM_RESERVE
#define VA_PAGE_RW			04h							;-- PAGE_READWRITE
#define VA_PAGE_RWX			40h							;-- PAGE_EXECUTE_READWRITE

#define _O_TEXT        	 	4000h  						;-- file mode is text (translated)
#define _O_BINARY       	8000h  						;-- file mode is binary (untranslated)
#define _O_WTEXT        	00010000h 					;-- file mode is UTF16 (translated)
#define _O_U16TEXT      	00020000h 					;-- file mode is UTF16 no BOM (translated)
#define _O_U8TEXT       	00040000h 					;-- file mode is UTF8  no BOM (translated)

#define GENERIC_WRITE		40000000h
#define GENERIC_READ 		80000000h
#define FILE_SHARE_READ		00000001h
#define FILE_SHARE_WRITE	00000002h
#define OPEN_EXISTING		00000003h

#define WEOF				FFFFh

#define FOREGROUND_BLACK 		   00h
#define FOREGROUND_BLUE 		   01h
#define FOREGROUND_GREEN 	 	   02h
#define FOREGROUND_CYAN 	 	   03h
#define FOREGROUND_RED 		 	   04h
#define FOREGROUND_MAGENTA	 	   05h
#define FOREGROUND_YELLOW	 	   06h
#define FOREGROUND_GREY		 	   07h
#define FOREGROUND_INTENSITY	   08h
#define FOREGROUND_WHITE	 	   0Fh
#define BACKGROUND_BLUE			   10h
#define BACKGROUND_CYAN 	 	   30h
#define BACKGROUND_GREEN		   20h
#define BACKGROUND_RED			   40h
#define BACKGROUND_MAGENTA	 	   50h
#define BACKGROUND_YELLOW	 	   60h
#define BACKGROUND_GREY		 	   70h
#define BACKGROUND_INTENSITY	   80h
#define COMMON_LVB_REVERSE_VIDEO 4000h
#define COMMON_LVB_UNDERSCORE    8000h


#define COORD_Y(value)      (value >>> 16)
#define COORD_X(value)      (value and 0000FFFFh)       
#define coord! integer!

CONSOLE_SCREEN_BUFFER_INFO!: alias struct! [
	size                [coord!]
	cursor              [coord!]
	attributes          [integer!]
	leftTop             [coord!]
	rightBottom         [coord!]
	maximumWindowSize   [coord!]
]

platform: context [

	#enum file-descriptors! [
		fd-stdout: 1									;@@ hardcoded, safe?
		fd-stderr: 2									;@@ hardcoded, safe?
	]

	page-size: 4096
	confd: -2

	buffer: allocate  1024
	pbuffer: buffer ;this stores buffer's head position

	csbi: declare CONSOLE_SCREEN_BUFFER_INFO!
	saved-cursor: declare coord!

	#import [
		LIBC-file cdecl [
			;putwchar: "putwchar" [
			;	wchar		[integer!]					;-- wchar is 16-bit on Windows
			;]
			wprintf: "wprintf" [
				[variadic]
				return: 	[integer!]
			]
			fflush: "fflush" [
				fd			[integer!]
				return:		[integer!]
			]
			_setmode: "_setmode" [
				handle		[integer!]
				mode		[integer!]
				return:		[integer!]
			]
			_get_osfhandle: "_get_osfhandle" [
				fd			[integer!]
				return:		[integer!]
			]
			;_open_osfhandle: "_open_osfhandle" [
			;	handle		[integer!]
			;	flags		[integer!]
			;	return:		[integer!]
			;]
		]
		"kernel32.dll" stdcall [
			VirtualAlloc: "VirtualAlloc" [
				address		[byte-ptr!]
				size		[integer!]
				type		[integer!]
				protection	[integer!]
				return:		[int-ptr!]
			]
			VirtualFree: "VirtualFree" [
				address 	[int-ptr!]
				size		[integer!]
				return:		[integer!]
			]
			WriteConsole: 	 "WriteConsoleW" [
				consoleOutput	[integer!]
				buffer			[byte-ptr!]
				charsToWrite	[integer!]
				numberOfChars	[int-ptr!]
				_reserved		[int-ptr!]
				return:			[integer!]
			]
			WriteFile: "WriteFile" [
				handle			[integer!]
				buffer			[c-string!]
				len				[integer!]
				written			[int-ptr!]
				overlapped		[integer!]
				return:			[integer!]
			]
			GetConsoleMode:	"GetConsoleMode" [
				handle			[integer!]
				mode			[int-ptr!]
				return:			[integer!]
			]
			SetConsoleTextAttribute: "SetConsoleTextAttribute" [
				handle 		[integer!]
				attributes  [integer!]
				return:		[integer!]
			]
			SetConsoleCursorPosition: "SetConsoleCursorPosition" [
				handle      [integer!]
				position    [coord!]
				return:     [integer!]
			]
			GetConsoleScreenBufferInfo: "GetConsoleScreenBufferInfo" [
				handle 		[integer!]
				info        [CONSOLE_SCREEN_BUFFER_INFO!]
				return:		[integer!]
			]
			FillConsoleOutputCharacter: "FillConsoleOutputCharacterW" [
				handle 		[integer!]
				wchar       [integer!]
				length      [integer!]
				writeCoord  [coord!]
				written     [int-ptr!]
				return:     [integer!]
			]
			FillConsoleOutputAttribute: "FillConsoleOutputAttribute" [
				handle 		[integer!]
				attributes  [integer!]
				length      [integer!]
				writeCoord  [coord!]
				written     [int-ptr!]
				return:     [integer!]
			]
		]
	]

	;-------------------------------------------
	;-- Allocate paged virtual memory region from OS
	;-------------------------------------------
	allocate-virtual: func [
		size 	[integer!]								;-- allocated size in bytes (page size multiple)
		exec? 	[logic!]								;-- TRUE => executable region
		return: [int-ptr!]								;-- allocated memory region pointer
		/local ptr prot
	][
		prot: either exec? [VA_PAGE_RWX][VA_PAGE_RW]

		ptr: VirtualAlloc
			null
			size
			VA_COMMIT_RESERVE
			prot

		if ptr = null [
			raise-error RED_ERR_VMEM_OUT_OF_MEMORY 0
		]
		ptr
	]

	;-------------------------------------------
	;-- Free paged virtual memory region from OS
	;-------------------------------------------
	free-virtual: func [
		ptr [int-ptr!]									;-- address of memory region to release
	][
		if negative? VirtualFree ptr ptr/value [
			raise-error RED_ERR_VMEM_RELEASE_FAILED as-integer ptr
		]
	]

	;-------------------------------------------
	;-- Initialize console ouput handle
	;-------------------------------------------
	init-console-out: func [][
		confd: simple-io/CreateFile
					"CONOUT$"
					GENERIC_WRITE
					FILE_SHARE_READ or FILE_SHARE_WRITE
					null
					OPEN_EXISTING
					0
					null
	]

	;-------------------------------------------
	;-- putwchar use windows api internal
	;-------------------------------------------
	putwchar: func [
		wchar	[integer!]								;-- wchar is 16-bit on Windows
		return:	[integer!]
		/local
			n	[integer!]
			cr	[integer!]
			con	[integer!]
	][
		n: 0
		cr: as integer! #"^M"

		con: GetConsoleMode _get_osfhandle fd-stdout :n		;-- test if output is a console
		either con > 0 [									;-- output to console
			if confd = -2 [init-console-out]
			if confd = -1 [return WEOF]
			WriteConsole confd (as byte-ptr! :wchar) 1 :n null
		][													;-- output to redirection file
			if wchar = as integer! #"^/" [					;-- convert lf to crlf
				WriteFile _get_osfhandle fd-stdout (as c-string! :cr) 2 :n 0
			]
			WriteFile _get_osfhandle fd-stdout (as c-string! :wchar) 2 :n 0
		]
		wchar
	]

	;-------------------------------------------
	;-- putbuffer use windows api internal
	;-------------------------------------------
	putbuffer: func [
		chars [integer!]
		return: [integer!]
		/local
			n	[integer!]
			con	[integer!]
	][
		n: 0
		con: GetConsoleMode _get_osfhandle fd-stdout :n		;-- test if output is a console
		either con > 0 [									;-- output to console
			if confd = -2 [init-console-out]
			if confd = -1 [return WEOF]					
			WriteConsole confd pbuffer chars :n null
		][													;-- output to redirection file
			WriteFile _get_osfhandle fd-stdout as c-string! pbuffer 2 * chars :n 0
		]
		buffer: pbuffer
		chars
	]

	;-------------------------------------------
	;-- ANSI escape sequence emulation          
	;-------------------------------------------

	clear-console: func[
		/local
			handle [integer!]
			num    [integer!]
			len    [integer!]
	][
		GetConsoleScreenBufferInfo stdout csbi
		num: 0
		len: COORD_X(csbi/size) * COORD_Y(csbi/size)
		FillConsoleOutputCharacter stdout as-integer #" " len 0 :num
		FillConsoleOutputAttribute stdout csbi/attributes len 0 :num ;@@ when I do this, next time changed background is not used to the end of line :/
		                                                             ;@@ but when I don't do this, previously used background would not be cleared
		SetConsoleCursorPosition stdout 0
	]
	console-store-position: does [
		GetConsoleScreenBufferInfo stdout csbi
		saved-cursor: csbi/cursor
	]
	set-console-cursor: func[
		position   [coord!]
	][
		SetConsoleCursorPosition stdout position
	]
	set-console-graphic: func[
		mode  [integer!]
	][
		SetConsoleTextAttribute stdout mode
	]
	update-graphic-mode: func[
		attribute  [integer!]
		value      [integer!]
		return: [integer!]
		/local
			tmp [integer!]
	][
		if attribute < 0 [
			GetConsoleScreenBufferInfo stdout csbi
			attribute: csbi/attributes
		]
		switch value [
			0  [attribute: FOREGROUND_GREY]
			1  [attribute: attribute or FOREGROUND_INTENSITY or BACKGROUND_INTENSITY]
			4  [attribute: attribute or COMMON_LVB_UNDERSCORE]
			7  [tmp: (attribute and F0h) >> 4 attribute: ((attribute and 0Fh) << 4) or tmp ] ;reverse
			30 [attribute: (attribute and F8h)]
			31 [attribute: (attribute and F8h) or FOREGROUND_RED]
			32 [attribute: (attribute and F8h) or FOREGROUND_GREEN]
			33 [attribute: (attribute and F8h) or FOREGROUND_YELLOW]
			34 [attribute: (attribute and F8h) or FOREGROUND_BLUE]
			35 [attribute: (attribute and F8h) or FOREGROUND_MAGENTA]
			36 [attribute: (attribute and F8h) or FOREGROUND_CYAN]
			37 [attribute: (attribute and F8h) or FOREGROUND_GREY]
			39 [attribute: attribute xor FOREGROUND_INTENSITY]
			40 [attribute: (attribute and 8Fh)]
			41 [attribute: (attribute and 8Fh) or BACKGROUND_RED]
			42 [attribute: (attribute and 8Fh) or BACKGROUND_GREEN]
			43 [attribute: (attribute and 8Fh) or BACKGROUND_YELLOW]
			44 [attribute: (attribute and 8Fh) or BACKGROUND_BLUE]
			45 [attribute: (attribute and 8Fh) or BACKGROUND_MAGENTA]
			46 [attribute: (attribute and 8Fh) or BACKGROUND_CYAN]
			47 [attribute: (attribute and 8Fh) or BACKGROUND_GREY]
			49 [attribute: attribute xor BACKGROUND_INTENSITY] ;
			default [attribute: value]
		]
		attribute
	]

	;-- Based on http://ascii-table.com/ansi-escape-sequences.php
	parse-ansi-sequence: func[
		str 	[byte-ptr!]
		unit    [integer!]
		return: [integer!]
		/local
			cp      [byte!]
			bytes   [integer!]
			state   [integer!]
			value1  [integer!]
			value2  [integer!]
			command [integer!]
			attribute [integer!]
			cursor  [coord!]
			col     [integer!]
			row     [integer!]
	][
		switch unit [
			Latin1 [
				if str/2 <> #"[" [return 0]
				str: str + 2
				bytes: 2
			]
			UCS-2  [
				if str/3 <> #"[" [return 0]
				str: str + 4
				bytes: 4
			]
			UCS-4  [
				if str/5 <> #"[" [return 0]
				str: str + 8
				bytes: 8
			]
		]
		state:   1
		value1:  0
		value2:  0
		attribute: -1
		until [
			cp: str/1
			str: str + unit
			bytes: bytes + unit
			switch state [
				1 [ ;value1 start
					case [
						all [cp >= #"0" cp <= #"9"][
							value1: ((value1 * 10) + (cp - #"0")) // FFFFh
							state: 2
						]
						cp = #";" [] ;do nothing
						cp = #"s" [	;-- Saves the current cursor position.
							console-store-position
							state: -1
						]
						cp = #"u" [ ;-- Returns the cursor to the position stored by the Save Cursor Position sequence.
							set-console-cursor saved-cursor
							state: -1
						]
						cp = #"K" [ ;-- Erase Line.
							;@@ todo
							state: -1
						]
						cp = #"J" [ ;-- Clear screen from cursor down.
							;@@ todo
							state: -1
						]
						any [cp = #"H" cp = #"f"] [
							set-console-cursor 0
							state: -1
						]
						cp = #"?" [	;@@ just for testing purposes
							GetConsoleScreenBufferInfo stdout csbi
							print-line "Screen buffer info:"
							print-line ["   size______ " COORD_X(csbi/size) "x" COORD_Y(csbi/size)]
							print-line ["   cursor____ " COORD_X(csbi/cursor) "x" COORD_Y(csbi/cursor)]
							print-line ["   attribute_ " csbi/attributes]
							state: -1
						]
						true [ state: -1 ]
					]
				]
				2 [ ;value1 continue
					case [
						all [cp >= #"0" cp <= #"9"][
							value1: ((value1 * 10) + (cp - #"0")) // FFFFh
						]
						cp = #";" [
							state: 3
						]
						cp = #"m" [
							attribute: update-graphic-mode attribute value1
							set-console-graphic attribute
							state: -1
						]
						cp = #"A" [ ;-- Cursor Up.
							GetConsoleScreenBufferInfo stdout csbi
							cursor: csbi/cursor
							row: COORD_Y(cursor) - value1
							if row < 0 [ row: 0 ]
							set-console-cursor (cursor and 0000FFFFh) or (row << 16)
							state: -1
						]
						cp = #"B" [ ;-- Cursor Down.
							GetConsoleScreenBufferInfo stdout csbi
							cursor: csbi/cursor
							row: COORD_Y(cursor) + value1
							if row < COORD_Y(csbi/size) [ row: COORD_Y(csbi/size) ]
							set-console-cursor (cursor and 0000FFFFh) or (row << 16)
							state: -1
						]
						cp = #"C" [ ;-- Cursor Forward.
							GetConsoleScreenBufferInfo stdout csbi
							cursor: csbi/cursor
							col: COORD_X(cursor) + value1
							if col > COORD_X(csbi/size)  [ col: COORD_X(csbi/size) ]
							set-console-cursor (cursor and FFFF0000h) or (col and 0000FFFFh)
							state: -1
						]
						cp = #"D" [ ;-- Cursor Backward.
							GetConsoleScreenBufferInfo stdout csbi
							cursor: csbi/cursor
							col: COORD_X(cursor) - value1
							if col < 0 [ col: 0 ]
							set-console-cursor (cursor and FFFF0000h) or (col and 0000FFFFh)
							state: -1
						]
						cp = #"J" [
							if value1 = 2 [clear-console]
							state: -1
						]
						true [ state: -1 ]
					]
				]
				3 [ ;value2 start
					case [
						all [cp >= #"0" cp <= #"9"][
							value2: ((value2 * 10) + (cp - #"0")) // FFFFh
							state: 4
						]
						cp = #";" [] ;do nothing
						true [ state: -1 ]
					]
				] ;value2 continue
				4 [
					case [
						all [cp >= #"0" cp <= #"9"][
							value2: ((value2 * 10) + (cp - #"0")) // FFFFh
						]
						cp = #"m" [
							attribute: update-graphic-mode update-graphic-mode attribute value1 value2
							set-console-graphic attribute
							state: -1 
						]
						cp = #";" [
							attribute: update-graphic-mode update-graphic-mode attribute value1 value2
							value1: 0
							value2: 0
							state: 1
						]
						any [cp = #"H" cp = #"f"] [ ;-- Cursor Position.
							set-console-cursor (value1 and 0000FFFFh) or (value2 << 16)
							state: -1
						]
						true [ state: -1 ]
					]
				]
			]
			state < 0
		]
		bytes
	]

	;-------------------------------------------
	;-- Print a UCS-4 string to console
	;-------------------------------------------
	print-UCS4: func [
		str    [int-ptr!]								;-- zero-terminated UCS-4 string
		/local
			cp [integer!]								;-- codepoint
	][
		assert str <> null

		while [cp: str/value not zero? cp][
			either str/value > FFFFh [
				cp: cp - 00010000h						;-- encode surrogate pair
				putwchar cp >> 10 + D800h				;-- emit lead
				putwchar cp and 03FFh + DC00h			;-- emit trail
			][
				putwchar cp								;-- UCS-2 codepoint
			]
			str: str + 1
		]
	]

	;-------------------------------------------
	;-- Print a UCS-4 string to console
	;-------------------------------------------
	print-line-UCS4: func [
		str    [int-ptr!]								;-- zero-terminated UCS-4 string
		/local
			cp [integer!]								;-- codepoint
	][
		assert str <> null
		print-UCS4 str									;@@ throw an error on failure
		putwchar 10										;-- newline
	]

	;-------------------------------------------
	;-- Print a UCS-2 string to console
	;-------------------------------------------
	print-UCS2: func [
		str 	[byte-ptr!]								;-- zero-terminated UCS-2 string
		/local
			b1    [byte!]
			b2    [byte!]
			chars [integer!]
			skip  [integer!]
	][
		assert str <> null
		chars: 0
		skip: 0
		while [
			b1: str/1
			b2: str/2
			((as-integer b2) << 8 + b1) <> 0
		][
			if all [b1 = #"^[" b2 = null-byte] [
				putbuffer chars
				chars: 0
				skip: parse-ansi-sequence str UCS-2
			]
			case [
				skip = 0 [
					buffer/1: b1
					buffer/2: b2
					chars: chars + 1
					buffer: buffer + 2
					str: str + 2
					if chars = 512 [  ; if the buffer has 1024 bytes, it has room for 512 chars
						putbuffer chars
						chars: 0
					]
				]
				skip > 0 [
					str: str + skip
					skip: 0
				]
			]

		]
		putbuffer chars
	]

	;-------------------------------------------
	;-- Print a UCS-2 string with newline to console
	;-------------------------------------------
	print-line-UCS2: func [
		str 	[byte-ptr!]								;-- zero-terminated UCS-2 string
	][
		assert str <> null
		print-UCS2 str									;@@ throw an error on failure
		buffer/1: #"^M"
		buffer/2: null-byte
		buffer/3: #"^/"
		buffer/4: null-byte
		putbuffer 2 									;-- newline
	]

	;-------------------------------------------
	;-- Print a Latin-1 string to console
	;-------------------------------------------
	print-Latin1: func [
		str 	[c-string!]								;-- zero-terminated Latin-1 string
		/local
			cp    [byte!]							    ;-- codepoint
			chars [integer!]							;-- mumber of used chars in buffer
			skip  [integer!]
	][
		assert str <> null
		chars: 0
		skip: 0
		while [cp: str/1  cp <> null-byte][
			if cp = #"^[" [
				putbuffer chars
				chars: 0
				skip: parse-ansi-sequence as byte-ptr! str Latin1
			]
			case [
				skip = 0 [
					buffer/1: cp
					buffer/2: null-byte ;this should be always 0 in Latin1
					str: str + 1
					chars: chars + 1
					buffer: buffer + 2
					if chars = 512 [  ; if the buffer has 1024 bytes, it has room for 512 chars
						putbuffer chars
						chars: 0
					]
				]
				skip > 0 [
					str: str + skip
					skip: 0
				]
			]
		]
		putbuffer chars
	]

	;-------------------------------------------
	;-- Print a Latin-1 string with newline to console
	;-------------------------------------------
	print-line-Latin1: func [
		str [c-string!]									;-- zero-terminated Latin-1 string
	][
		assert str <> null
		print-Latin1 str
		buffer/1: #"^M"
		buffer/2: null-byte
		buffer/3: #"^/"
		buffer/4: null-byte
		putbuffer 2 									;-- newline
	]

	;-------------------------------------------
	;-- Print a UTF-8 string to console         
	;-------------------------------------------
	print-UTF-8: func [
		str 	[c-string!]								;-- zero-terminated UTF-8 string
		/local
			cp    [integer!]							;-- codepoint
			chars [integer!]							;-- mumber of used chars in buffer
			skip  [integer!]
			used  [integer!]
			cp2   [integer!]
	][
		assert str <> null
		chars: 0
		skip: 0
		while [
			used: 4 ;@@ decode-utf8-char is doing check if there is enough bytes, is it safe to always say there is at least 4 bytes?
			cp: unicode/decode-utf8-char str :used
			cp > 0
		][
			if cp = 1Bh [ ;-- #"^[" = ansi escape char
				putbuffer chars
				chars: 0
				skip: parse-ansi-sequence as byte-ptr! str Latin1
			]
			case [
				skip = 0 [
					case [
						cp <= FFh [
							buffer/1: as byte! cp
							buffer/2: null-byte ;this should be always 0 in Latin1
							chars: chars + 1
							buffer: buffer + 2
						]
						cp <= FFFFh [
							buffer/1: as byte! cp
							buffer/2: as byte! cp >> 8
							chars: chars + 1
							buffer: buffer + 2
						]
						true [
							;@@ this should be tested, I don't know how a.t.m.
							cp2: cp >> 10 + D800h				;-- emit lead
							buffer/1: as byte! cp2
							buffer/2: as byte! cp2 >> 8
							cp2: cp and 03FFh + DC00h			;-- emit trail
							buffer/3: as byte! cp2
							buffer/4: as byte! cp2 >> 8
							chars: chars + 2
							buffer: buffer + 4
						]
					]
					str: str + used
					if chars >= 510 [  ; if the buffer has 1024 bytes, it has room for 512 chars
						putbuffer chars
						chars: 0
					]
				]
				skip > 0 [
					str: str + skip
					skip: 0
				]
			]
		]
		putbuffer chars
	]

	;-------------------------------------------
	;-- Red/System Unicode replacement printing functions
	;-------------------------------------------

	prin*: func [s [c-string!] return: [c-string!] /local p][
		p: s
		while [p/1 <> null-byte][
			putwchar as-integer p/1
			p: p + 1
		]
		s
	]

	prin-int*: func [i [integer!] return: [integer!]][
		wprintf ["%^(00)i^(00)^(00)" i]								;-- UTF-16 literal string
		fflush null													;-- flush all streams
		i
	]

	prin-hex*: func [i [integer!] return: [integer!]][
		wprintf ["%^(00)0^(00)8^(00)X^(00)^(00)" i]					;-- UTF-16 literal string
		fflush null
		i
	]

	prin-float*: func [f [float!] return: [float!]][
		wprintf ["%^(00).^(00)1^(00)4^(00)g^(00)^(00)" f]		;-- UTF-16 literal string
		fflush null
		f
	]

	prin-float32*: func [f [float32!] return: [float32!]][
		wprintf ["%^(00).^(00)7^(00)g^(00)^(00)" as-float f]	;-- UTF-16 literal string
		fflush null
		f
	]

	;-------------------------------------------
	;-- Do platform-specific initialization tasks
	;-------------------------------------------
	init: does [
		#if unicode? = yes [
			_setmode fd-stdout _O_U16TEXT				;@@ throw an error on failure
			_setmode fd-stderr _O_U16TEXT				;@@ throw an error on failure
		]
	]
]