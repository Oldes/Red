Red/System [
	Title:	"IClassFactory interface"
	Author: "Oldes"
	File: 	%IClassFactory.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IClassFactory: [00000001h 00000000h 000000C0h 46000000h]

IClassFactory!: alias struct! [
	QueryInterface       [QueryInterface!]
	AddRef               [AddRef!]
	Release              [Release!]
	CreateInstance       [function! [this [this!] pUnkOuter [int-ptr!] riid [int-ptr!] ppvObject [interface!] return: [integer!]]]
	LockServer           [function! [this [this!] fLock [logic!] return: [integer!]]]
]