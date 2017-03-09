Red/System [
	Title:	"Windows browser widget win32 dependencies"
	Author: "Oldes"
	File: 	%browser-win32.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

#define handle!	[pointer! [integer!]]




#define COINIT_APARTMENTTHREADED	2
#define CLSCTX_INPROC_SERVER 	1
#define CLSCTX_INPROC_HANDLER	2
#define CLSCTX_INPROC           3						;-- CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER


#define CS_VREDRAW			1
#define CS_HREDRAW			2
#define CS_DBLCLKS			8


#define WS_OVERLAPPEDWINDOW	00CF0000h
#define SW_SHOWDEFAULT		10

#define OLEIVERB_SHOW -1


#define WIN32_LOWORD(param) (param and FFFFh << 16 >> 16)	;-- trick to force sign extension
#define WIN32_HIWORD(param) (param >> 16)


;-------------------------------------------------
;-- from view/backends/windows/win32.reds
RECT_STRUCT: alias struct! [
	left		[integer!]
	top			[integer!]
	right		[integer!]
	bottom		[integer!]
]
tagMSG: alias struct! [
	hWnd	[handle!]
	msg		[integer!]
	wParam	[integer!]
	lParam	[integer!]
	time	[integer!]
	x		[integer!]									;@@ POINT struct
	y		[integer!]	
]
wndproc-cb!: alias function! [
	hWnd	[handle!]
	msg		[integer!]
	wParam	[integer!]
	lParam	[integer!]
	return: [integer!]
]
WNDCLASSEX: alias struct! [
	cbSize		  [integer!]
	style		  [integer!]
	lpfnWndProc	  [wndproc-cb!]
	cbClsExtra    [integer!]
	cbWndExtra    [integer!]
	hInstance	  [handle!]
	hIcon	  	  [handle!]
	hCursor		  [handle!]
	hbrBackground [integer!]
	lpszMenuName  [c-string!]
	lpszClassName [c-string!]
	hIconSm	  	  [integer!]
]


;--from COM.reds =====================:

#define VT_BSTR			8
#define VT_VARIANT		12

#define COM_SAFE_RELEASE(interface this) [
	if this <> null [
		interface: as IUnknown this/vtbl
		interface/Release this
		this: null
	]
]

this!: alias struct! [vtbl [integer!]]

interface!: alias struct! [
	ptr [this!]
]

QueryInterface!: alias function! [
	this		[this!]
	riid		[int-ptr!]
	ppvObject	[interface!]
	return:		[integer!]
]

AddRef!: alias function! [
	this		[this!]
	return:		[integer!]
]

Release!: alias function! [
	this		[this!]
	return:		[integer!]
]


tagVARIANT: alias struct! [
	data1		[integer!]
	data2		[integer!]
	data3		[integer!]
	data4		[integer!]
]
tagGUID: alias struct! [
	data1		[integer!]
	data2		[integer!]
	data3		[integer!]
	data4		[integer!]
]


#import [
	"kernel32.dll" stdcall [
		GlobalAlloc: "GlobalAlloc" [
			flags		[integer!]
			size		[integer!]
			return:		[handle!]
		]
		GetModuleHandle: "GetModuleHandleW" [
			lpModuleName [integer!]
			return:		 [handle!]
		]
		GetLastError: "GetLastError" [
			return: [integer!]
		]
		InterlockedIncrement: "InterlockedIncrement" [
		;Increments (increases by one) the value of the specified 32-bit variable as an atomic operation.
			Addend [int-ptr!]
			return: [integer!]
		]
	]
	"ole32.dll" stdcall [
		;--from Com.reds
		CoInitializeEx: "CoInitializeEx" [
			reserved	[integer!]
			dwCoInit	[integer!]
			return:		[integer!]
		]
		CoUninitialize: "CoUninitialize" []
		CoCreateInstance: "CoCreateInstance" [
			rclsid		 [int-ptr!]
			pUnkOuter	 [integer!]
			dwClsContext [integer!]
			riid		 [int-ptr!]
			ppv			 [interface!]
			return:		 [integer!]
		]
		;------------
		CoGetClassObject: "CoGetClassObject" [
			rclsid		 [int-ptr!]
			dwClsContext [integer!]
			pServerInfo  [int-ptr!]
			riid		 [int-ptr!]
			ppv			 [interface!]
			return:		 [integer!]
		]
		OleInitialize: "OleInitialize" [
			pvReserved [int-ptr!]
			return:  [integer!]
		]
		OleUninitialize: "OleUninitialize" [
			return: [integer!]
		]
		OleSetContainedObject: "OleSetContainedObject" [
			pUnknown   [this!]
			fContained [logic!]
			return:    [integer!]
		]
	]
	"user32.dll" stdcall [
		SetWindowLong: "SetWindowLongA" [
			hWnd      [int-ptr!]
			nIndex    [integer!]
			dwNewLong [integer!]
			return:   [integer!]
		]
		GetWindowLong: "GetWindowLongW" [
			hWnd		[handle!]
			nIndex		[integer!]
			return: 	[integer!]
		]
		RegisterClassEx: "RegisterClassExW" [
			lpwcx		[WNDCLASSEX]
			return: 	[integer!]
		]
		CreateWindowEx: "CreateWindowExW" [
			dwExStyle	 [integer!]
			lpClassName	 [c-string!]
			lpWindowName [c-string!]
			dwStyle		 [integer!]
			x			 [integer!]
			y			 [integer!]
			nWidth		 [integer!]
			nHeight		 [integer!]
			hWndParent	 [handle!]
			hMenu	 	 [handle!]
			hInstance	 [handle!]
			lpParam		 [int-ptr!]
			return:		 [handle!]
		]
		DefWindowProc: "DefWindowProcW" [
			hWnd		[handle!]
			msg			[integer!]
			wParam		[integer!]
			lParam		[integer!]
			return: 	[integer!]
		]
		ShowWindow: "ShowWindow" [
			hWnd		[handle!]
			nCmdShow	[integer!]
			return:		[logic!]
		]
		UpdateWindow: "UpdateWindow" [
			hWnd		[handle!]
			return:		[logic!]
		]
		GetMessage: "GetMessageW" [
			msg			[tagMSG]
			hWnd		[handle!]
			wParam		[integer!]
			lParam		[integer!]
			return: 	[integer!]
		]
		TranslateMessage: "TranslateMessage" [
			msg			[tagMSG]
			return: 	[logic!]
		]
		DispatchMessage: "DispatchMessageW" [
			msg			[tagMSG]
			return: 	[integer!]
		]
		PostQuitMessage: "PostQuitMessage" [
			nExitCode	[integer!]
		]
		GetClientRect: "GetClientRect" [
			hWnd		[handle!]
			lpRect		[RECT_STRUCT]
			return:		[integer!]
		]
	]
	"oleaut32.dll" stdcall [
		SysAllocString: "SysAllocString" [
			psz		[c-string!]
			return:	[byte-ptr!]
		]
		SysFreeString: "SysFreeString" [
			bstr	[byte-ptr!]
		]
		VariantInit: "VariantInit" [
			pvarg	[tagVARIANT]
		]
		VariantClear: "VariantClear" [
			pvarg	[tagVARIANT]
		]
		SafeArrayCreateVector: "SafeArrayCreateVector" [
			type	[integer!]
			start	[integer!]
			size	[integer!]
			return: [int-ptr!]
		]
		SafeArrayCreate: "SafeArrayCreate" [
			vt    [integer!]
			cDims [integer!]
			rgsabound [tagSAFEARRAYBOUND]
			return: [int-ptr!]
		]
		SafeArrayAccessData: "SafeArrayAccessData" [
			psa		[integer!]
			ppvData [int-ptr!]
			return: [integer!]
		]
		SafeArrayDestroy: "SafeArrayDestroy" [
			psa		[integer!]
			return:	[integer!]
		]
	]
]
init-variant: func [
	var [tagVARIANT]
][
	set-memory as byte-ptr! var null-byte size? tagVARIANT
	VariantInit var
]