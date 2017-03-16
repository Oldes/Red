Red/System [
	Title:	"IOleInPlaceFrame interface"
	Author: "Oldes"
	File: 	%IOleInPlaceFrame.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IOleInPlaceFrame: [00000116h 00000000h 000000C0h 46000000h] 

Frame_GetWindow!: alias function! [[callback] 
	this   [this!]
	lphwnd [int-ptr!]         ;HWND FAR* 
	return: [integer!]
]
Frame_ContextSensitiveHelp!: alias function! [[callback] 
	this   [this!]
	fEnterMode [logic!]       ;BOOL
	return: [integer!]
]
Frame_GetBorder!: alias function! [[callback] 
	this   [this!]
	lprectBorder [LPRECT!]
	return: [integer!]
]
Frame_RequestBorderSpace!: alias function! [[callback] 
	this   [this!]
	pborderwidths [LPCBORDERWIDTHS!]
	return: [integer!]
]
Frame_SetBorderSpace!: alias function! [[callback] 
	this   [this!]
	pborderwidths [LPCBORDERWIDTHS!]
	return: [integer!]
]
Frame_SetActiveObject!: alias function! [[callback] 
	this   [this!]
	pActiveObject [int-ptr!]  ;IOleInPlaceActiveObject *
	pszObjName [int-ptr!]     ;LPCOLESTR
	return: [integer!]
]
Frame_InsertMenus!: alias function! [[callback] 
	this   [this!]
	hmenuShared [int-ptr!] ;HMENU
	lpMenuWidths [int-ptr!] ;LPOLEMENUGROUPWIDTHS 
	return: [integer!]
]
Frame_SetMenu!: alias function! [[callback] 
	this   [this!]
	hmenuShared [int-ptr!] ;HMENU
	holemenu [int-ptr!] ;HOLEMENU
	hwndActiveObject [int-ptr!] ;HWND 
	return: [integer!]
]
Frame_RemoveMenus!: alias function! [[callback] 
	this   [this!]
	hmenuShared [int-ptr!] ;HMENU
	return: [integer!]
]
Frame_SetStatusText!: alias function! [[callback] 
	this   [this!]
	pszStatusText [int-ptr!] ;LPCOLESTR
	return: [integer!]
]
Frame_EnableModeless!: alias function! [[callback] 
	this   [this!]
	fEnable [logic!]
	return: [integer!]
]
Frame_TranslateAccelerator!: alias function! [[callback] 
	this   [this!]
	lpmsg  [LPMSG!]
	wID    [integer!] ;@@ SHOULD BE WORD!
	return: [integer!]
]

IOleInPlaceFrame!: alias struct! [
	QueryInterface       [QueryInterface!]
	AddRef               [AddRef!]
	Release              [Release!]
	GetWindow            [Frame_GetWindow!]
	ContextSensitiveHelp [Frame_ContextSensitiveHelp!]
	GetBorder            [Frame_GetBorder!]
	RequestBorderSpace   [Frame_RequestBorderSpace!]
	SetBorderSpace       [Frame_SetBorderSpace!]
	SetActiveObject      [Frame_SetActiveObject!]
	InsertMenus          [Frame_InsertMenus!]
	SetMenu              [Frame_SetMenu!]
	RemoveMenus          [Frame_RemoveMenus!]
	SetStatusText        [Frame_SetStatusText!]
	EnableModeless       [Frame_EnableModeless!]
	TranslateAccelerator [Frame_TranslateAccelerator!]
]
