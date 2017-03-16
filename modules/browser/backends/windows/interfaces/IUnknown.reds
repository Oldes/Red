Red/System [
	Title:	"IUnknown interface"
	Author: "Oldes"
	File: 	%IUnknown.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IUnknown: [00000000h 00000000h 000000C0h 46000000h]

IUnknown: alias struct! [
	QueryInterface			[QueryInterface!]
	AddRef					[AddRef!]
	Release					[Release!]
]