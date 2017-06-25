Red [
	Purpose: "Test the GUI auto-update mode"
	Needs: 'View
]

system/view/debug?: no ;turn this on to see more info

result: none


win: layout [
	title "VID drop-files event test"
	below
	text "Drop file or multiple files into this window"
	result: area 600x400 "no files dropped yet"
]

;this is example how to handle dropped files per window:

win/actors: make object! [
	on-drop-files: function [face [object!] event [event!]][
		clear result/text
		foreach file event/picked [
			append append result/text file lf
		]
	]
]

view win

;or it is possible to handle it for all windows:
;note: print output will be visible only if run from console

on-drop-files-global: func [face [object!] event [event!]][
	if event/type = 'drop-files [
		print "dropped-files:"
		clear result/text
		foreach file event/picked [
			probe file
			append append result/text file lf
		]
		print "target face:"
		dump-face face
	]
	none
]

insert-event-func :on-drop-files-global

view/no-wait win
view layout [
	size 550x240
	title "VID drop-files event test 2"
	text "This is just some window for testing global on-drop-files event."
]

;this will remove the global handler:
remove-event-func :on-drop-files-global
