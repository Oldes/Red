Red/System [
	Title:	"IOleInPlaceObject interface"
	Author: "Oldes"
	File: 	%IOleInPlaceObject.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IOleInPlaceObject: [00000113h 00000000h 000000C0h 46000000h]

IOleInPlaceObject!: alias struct! [
	QueryInterface       [QueryInterface!]
	AddRef               [AddRef!]
	Release              [Release!]
	GetWindow [integer!]
    ;        __RPC__in IOleInPlaceObject * This,
    ;        /* [out] */ __RPC__deref_out_opt HWND *phwnd);
    ContextSensitiveHelp [integer!]
    ;        __RPC__in IOleInPlaceObject * This,
    ;        /* [in] */ BOOL fEnterMode);
    InPlaceDeactivate [integer!]
    ;        __RPC__in IOleInPlaceObject * This);
    UIDeactivate [integer!]
    ;        __RPC__in IOleInPlaceObject * This);
    SetObjectRects [function! [this [this!] lprcPosRect [LPRECT!] lprcClipRect [LPRECT!] return: [integer!]]]
    ReactivateAndUndo [integer!]
    ;        __RPC__in IOleInPlaceObject * This);
]