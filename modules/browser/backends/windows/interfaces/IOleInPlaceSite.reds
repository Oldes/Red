Red/System [
	Title:	"IOleInPlaceSite interface"
	Author: "Oldes"
	File: 	%IOleInPlaceSite.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IOleInPlaceSite: [00000119h 00000000h 000000C0h 46000000h]

;Manages the interaction between the container and the object's in-place client site. 
;Recall that the client site is the display site for embedded objects, and provides 
;position and conceptual information about the object.

;This interface provides methods that manage in-place objects. With IOleInPlaceSite, 
;you can determine if an object can be activated and manage its activation and deactivation. 
;You can notify the container when one of its objects is being activated and inform the 
;container that a composite menu will replace the container's regular menu. 
;It provides methods that make it possible for the in-place object to retrieve 
;the window object hierarchy, and the position in the parent window where the object should 
;place its in-place activation window. Finally, it determines how the container scrolls 
;the object, manages the object undo state, and notifies the object when its borders have changed.

;-> https://msdn.microsoft.com/en-us/library/windows/desktop/ms686586(v=vs.85).aspx

InPlace_GetWindow!: alias function! [
	this [this!] 
	lphwnd [int-ptr!] ;HWND FAR* 
	return: [integer!]
]
InPlace_ContextSensitiveHelp!: alias function! [
	this [this!]
	fEnterMode [logic!]
	return: [integer!]
]
InPlace_CanInPlaceActivate!: alias function! [
	this [this!]
	return: [integer!]
]
InPlace_OnInPlaceActivate!: alias function! [
	this [this!]
	return: [integer!]
]
InPlace_OnUIActivate!: alias function! [
	this [this!]
	return: [integer!]
]
InPlace_GetWindowContext!: alias function! [
	this [this!]
	lplpFrame [int-ptr!] ;LPOLEINPLACEFRAME FAR* 
	lplpDoc [int-ptr!] ;LPOLEINPLACEUIWINDOW FAR* 
	lprcPosRect  [LPRECT!]
	lprcClipRect [LPRECT!]
	lpFrameInfo  [tagOIFI!] ;LPOLEINPLACEFRAMEINFO
	return: [integer!]
]
InPlace_Scroll!: alias function! [
	this [this!]
	scrollExtent [SIZE!]
	return: [integer!]
]
InPlace_OnUIDeactivate!: alias function! [
	this [this!]
	fUndoable [logic!]
	return: [integer!]
]
InPlace_OnInPlaceDeactivate!: alias function! [
	this [this!]
	return: [integer!]
]
InPlace_DiscardUndoState!: alias function! [
	this [this!]
	return: [integer!]
]
InPlace_DeactivateAndUndo!: alias function! [
	this [this!]
	return: [integer!]
]
InPlace_OnPosRectChange!: alias function! [
	this [this!]
	lprcPosRect [LPCRECT!]
	return: [integer!]
]


IOleInPlaceSite!: alias struct! [
	QueryInterface         [QueryInterface!]
	AddRef                 [AddRef!]
	Release                [Release!]
	GetWindow              [InPlace_GetWindow!]
	ContextSensitiveHelp   [InPlace_ContextSensitiveHelp!]
	CanInPlaceActivate     [InPlace_CanInPlaceActivate!]
	OnInPlaceActivate      [InPlace_OnInPlaceActivate!]
	OnUIActivate           [InPlace_OnUIActivate!]
	GetWindowContext       [InPlace_GetWindowContext!]
	Scroll                 [InPlace_Scroll!]
	OnUIDeactivate         [InPlace_OnUIDeactivate!]
	OnInPlaceDeactivate    [InPlace_OnInPlaceDeactivate!]
	DiscardUndoState       [InPlace_DiscardUndoState!]
	DeactivateAndUndo      [InPlace_DeactivateAndUndo!]
	OnPosRectChange        [InPlace_OnPosRectChange!]
]