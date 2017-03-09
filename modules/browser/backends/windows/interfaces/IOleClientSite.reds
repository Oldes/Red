Red/System [
	Title:	"IOleClientSite interface"
	Author: "Oldes"
	File: 	%IOleClientSite.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IOleClientSite: [00000118h 00000000h 000000C0h 46000000h]

Site_SaveObject!: alias function! [this [this!] return: [integer!]]
Site_GetMoniker!: alias function! [this [this!] dwAssign [integer!] dwWhichMoniker [integer!] ppmk [int-ptr!] return: [integer!]]
Site_GetContainer!: alias function! [this [this!] ppContainer [int-ptr!] return: [integer!]]
Site_ShowObject!: alias function! [this [this!] return: [integer!]] 
Site_OnShowWindow!: alias function! [this [this!] fShow [logic!] return: [integer!]]
Site_RequestNewObjectLayout!: alias function! [this [this!] return: [integer!]]

IOleClientSite!: alias struct! [
	QueryInterface         [QueryInterface!]
	AddRef                 [AddRef!]
	Release                [Release!]
	SaveObject             [Site_SaveObject!]
	GetMoniker             [Site_GetMoniker!]
	GetContainer           [Site_GetContainer!]
	ShowObject             [Site_ShowObject!]
	OnShowWindow           [Site_OnShowWindow!]
	RequestNewObjectLayout [Site_RequestNewObjectLayout!]
]