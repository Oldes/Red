Red/System [
	Title:	"IServiceProvider interface"
	Author: "Oldes"
	File: 	%IServiceProvider.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IServiceProvider: [6D5140C1h 11CE7436h AA003480h FA096000h]

;Provides a generic access mechanism to locate a GUID-identified service.

;-> https://msdn.microsoft.com/en-us/library/cc678965(v=vs.85).aspx

IServiceProvider!: alias struct! [
	QueryInterface   [QueryInterface!]
	AddRef           [AddRef!]
	Release          [Release!]
	QueryService [
		function! [this [this!]
			guidService [int-ptr!]   ;/* [annotation][in] */ _In_  REFGUID guidService,
			riid        [int-ptr!]   ;/* [annotation][in] */ _In_  REFIID riid,
			ppvObject   [interface!] ;/* [annotation][out] */ _Outptr_  void **ppvObject);
			return:     [integer!] 
	]]
]

