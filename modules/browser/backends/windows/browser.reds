Red/System [
	Title:	"Windows browser widget"
	Author: "Oldes"
	File: 	%browser.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

#define TRACE(value) [
	;print-line value
]

#define GWL_USERDATA -21
#define OLEIVERB_SHOW -1



tagSAFEARRAYBOUND: alias struct! [
	cElements [integer!]
	lLbound   [integer!]
]


;--------------------------------------------------
;#include %../../../../runtime/platform/COM.reds




#either modules contains 'View [
	IID_IUnknown: [00000000h 00000000h 000000C0h 46000000h]

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

	#import [
		"kernel32.dll" stdcall [
			GlobalAlloc: "GlobalAlloc" [
				flags		[integer!]
				size		[integer!]
				return:		[handle!]
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
			GetClientRect: "GetClientRect" [
				hWnd		[handle!]
				lpRect		[RECT_STRUCT]
				return:		[integer!]
			]
		]
		"ole32.dll" stdcall [
			CoGetClassObject: "CoGetClassObject" [
				rclsid		 [int-ptr!]
				dwClsContext [integer!]
				pServerInfo  [int-ptr!]
				riid		 [int-ptr!]
				ppv			 [interface!]
				return:		 [integer!]
			]
			OleSetContainedObject: "OleSetContainedObject" [
				pUnknown   [this!]
				fContained [logic!]
				return:    [integer!]
			]
		]
		"oleaut32.dll" stdcall [
			SafeArrayCreate: "SafeArrayCreate" [
				vt    [integer!]
				cDims [integer!]
				rgsabound [tagSAFEARRAYBOUND]
				return: [int-ptr!]
			]
		]
		"user32.dll" stdcall [
			DefWindowProc: "DefWindowProcW" [
				hWnd		[handle!]
				msg			[integer!]
				wParam		[integer!]
				lParam		[integer!]
				return: 	[integer!]
			]
		]
	]
][
	;View module is not used so we are probably making stand alone version
	;so we import all definitions which norally comes with View

	#include %browser-win32.reds
	#include %interfaces/IUnknown.reds
]

POINT!: alias struct! [
	x [integer!]
	y [integer!]
]
SIZE!: alias struct!  [
	cx [integer!]
	cy [integer!]
]
tagOIFI!: alias struct! [
    cb      [integer!]  ;UINT
    fMDIApp [logic!]    ;BOOL
    hwndFrame [handle!] ;HWND
    haccel    [handle!] ;HACCEL
    cAccelEntries [integer!] ;UINT
]



#define LPCBORDERWIDTHS! LPRECT!
#define LPMSG! int-ptr!
#define LPRECT! RECT_STRUCT
#define LPCRECT! LPRECT!


#include %interfaces/IClassFactory.reds
#include %interfaces/IDispatch.reds
#include %interfaces/IDocHostUIHandler.reds
#include %interfaces/IHTMLDocument2.reds
#include %interfaces/IOleClientSite.reds
#include %interfaces/IOleCommandTarget.reds
#include %interfaces/IOleControlSite.reds
#include %interfaces/IOleInPlaceFrame.reds
#include %interfaces/IOleInPlaceObject.reds
#include %interfaces/IOleInPlaceSite.reds
#include %interfaces/IOleObject.reds
#include %interfaces/IRunnableObject.reds
#include %interfaces/IServiceProvider.reds

#include %interfaces/IWebBrowser2.reds


CLSID_WebBrowser: [8856F961h 11D0340Ah C0006BA9h A205D74Fh]

#define AS_THIS(obj) [as this! obj/ptr]
#define IS_INTERFACE(a b) [0 = compare-memory as byte-ptr! a as byte-ptr! b 16]
#define HEXA(a) [as int-ptr! a]

#define NOTIMPLEMENTED [return 80004001h]
#define E_NOINTERFACE 80004002h
#define S_OK 0
#define S_FALSE 1

iid-to-str: func[
	riid    [int-ptr!]
	return: [c-string!]
	/local
		s [c-string!]
][
	case [
		IS_INTERFACE(riid IID_IUnknown)          [s: "IID_IUnknown"]
		IS_INTERFACE(riid IID_IDispatch)         [s: "IID_IDispatch"]
		IS_INTERFACE(riid IID_IOleClientSite)    [s: "IID_IOleClientSite"]
		IS_INTERFACE(riid IID_IOleInPlaceSite)   [s: "IID_IOleInPlaceSite"]
		IS_INTERFACE(riid IID_IRunnableObject)   [s: "IID_IRunnableObject"]
		IS_INTERFACE(riid IID_IDocHostUIHandler) [s: "IID_IDocHostUIHandler"]
		IS_INTERFACE(riid IID_IOleObject)        [s: "IID_IOleObject"]
		IS_INTERFACE(riid IID_IOleInPlaceFrame)  [s: "IID_IOleInPlaceFrame"]
		IS_INTERFACE(riid IID_IOleInPlaceObject) [s: "IID_IOleInPlaceObject"]
		IS_INTERFACE(riid IID_IClassFactory)     [s: "IID_IClassFactory"]
		IS_INTERFACE(riid IID_IServiceProvider)  [s: "IID_IServiceProvider"]
		IS_INTERFACE(riid IID_IOleCommandTarget) [s: "IID_IOleCommandTarget"]
		IS_INTERFACE(riid IID_IWebBrowser2)      [s: "IID_IWebBrowser2"]
		IS_INTERFACE(riid IID_IHTMLDocument2)    [s: "IID_IHTMLDocument2"]
		IS_INTERFACE(riid IID_IOleControlSite)   [s: "IID_IOleControlSite"]
		true [
			print ["{" HEXA(riid/1) " " HEXA(riid/2) " " HEXA(riid/3) " " HEXA(riid/4) "} "]
			s: ""
		]
	]
	s
]

hInstance:  as handle! 0
ArrayBound: declare tagSAFEARRAYBOUND [1 0] ;// This is used by DisplayHTMLStr(). It can be global because we never change it.


BrowserImpl!: alias struct! [
	object  [interface!]
	window  [handle!]
	client  [IOleClientSite!]	  ;// My IOleClientSite object. Must be first.
	inplace [IOleInPlaceSite!]    ;// My IOleInPlaceSite object. A convenient place to put it.
	frame   [IOleInPlaceFrame!]
	ui      [IDocHostUIHandler!]  ;// My IDocHostUIHandler object. Must be first within my _IDocHostUIHandlerEx.
	service [IServiceProvider!]
]

ServiceProvider_QueryInterface: func[
	[callback]
	this		[this!]
	riid		[int-ptr!]
	ppvObject	[interface!]
	return:		[integer!]
][
	;TRACE(["ServiceProvider_QueryInterface-> this: " this " riid:" riid])
	;Site_QueryInterface 
	;	as this! ((as int-ptr! this) - 3)
	;	riid
	;	ppvObject
	E_NOINTERFACE
]
ServiceProvider_AddRef:    func [[callback] this [this!] return: [integer!]][ 1 ]
ServiceProvider_Release:   func [[callback] this [this!] return: [integer!]][ 1 ]
ServiceProvider_QueryService: func [
	[callback]
	this [this!]
	guidService [int-ptr!]   ;/* [annotation][in] */ _In_  REFGUID guidService,
	riid        [int-ptr!]   ;/* [annotation][in] */ _In_  REFIID riid,
	ppvObject   [interface!] ;/* [annotation][out] */ _Outptr_  void **ppvObject);
	return:     [integer!] 
][
	;TRACE(["MyIServiceProvider/QueryService " this " " iid-to-str riid])
	E_NOINTERFACE
]

MyIServiceProvider: declare IServiceProvider!
MyIServiceProvider/QueryInterface: :ServiceProvider_QueryInterface
MyIServiceProvider/AddRef:         :ServiceProvider_AddRef
MyIServiceProvider/Release:        :ServiceProvider_Release
MyIServiceProvider/QueryService:   :ServiceProvider_QueryService



;--//////////////////////////////////// My IDocHostUIHandler functions  //////////////////////////////////////
;--// The browser object asks us for the pointer to our IDocHostUIHandler object by calling our IOleClientSite's
;--// QueryInterface (ie, Site_QueryInterface) and specifying a REFIID of IID_IDocHostUIHandler.
;--//
;--// NOTE: You need at least IE 4.0. Previous versions do not ask for, nor utilize, our IDocHostUIHandler functions.

UI_QueryInterface: func[
	[callback]
	this		[this!]
	riid		[int-ptr!]
	ppvObject	[interface!]
	return:		[integer!]
][
	TRACE(["UI_QueryInterface-> this: " this " riid:" riid])
	Site_QueryInterface 
		as this! ((as int-ptr! this) - 3)
		riid
		ppvObject
]
UI_AddRef: func [[callback] this [this!] return: [integer!]][ 1 ]
UI_Release: func [[callback] this [this!] return: [integer!]][ 2 ]
UI_ShowContextMenu: func [
	[callback]
	this [this!]
	dwID [integer!]
	ppt [POINT!]
	pcmdtReserved [int-ptr!] ;IUnknown __RPC_FAR *
	pdispReserved [int-ptr!] ;IDispatch __RPC_FAR *
	return: [integer!]
][ S_OK ]
UI_GetHostInfo: func [
	[callback]
	this [this!] 
	pInfo [int-ptr!] ;DOCHOSTUIINFO __RPC_FAR *
	return: [integer!]
][ S_OK ]
UI_ShowUI: func [
	[callback]
	this [this!]
	dwID [integer!]
	pActiveObject [int-ptr!] ;IOleInPlaceActiveObject __RPC_FAR *
	pCommandTarget [int-ptr!] ;IOleCommandTarget __RPC_FAR *
	pFrame [int-ptr!] ;IOleInPlaceFrame __RPC_FAR *
	pDoc [int-ptr!] ;IOleInPlaceUIWindow __RPC_FAR *
	return: [integer!]
][ S_OK ]
UI_HideUI: func [[callback] this [this!] return: [integer!]][ S_OK ]
UI_UpdateUI: func [[callback] this [this!] return: [integer!]][ S_OK ]
UI_EnableModeless: func [[callback] this [this!] fEnable [logic!] return: [integer!]][ S_OK ]
UI_OnDocWindowActivate: func [[callback] this [this!] fActivate [logic!] return: [integer!]][ S_OK ]
UI_OnFrameWindowActivate: func [[callback] this [this!] fActivate [logic!] return: [integer!]][ S_OK ]
UI_ResizeBorder: func [
	[callback] this [this!]
	prcBorder [LPCRECT!]
	pUIWindow [int-ptr!] ;IOleInPlaceUIWindow __RPC_FAR *
	fRameWindow [logic!]
	return: [integer!]
][ S_OK ]
UI_TranslateAccelerator: func [
	[callback] this [this!]
	lpMsg [LPMSG!]
	pguidCmdGroup [int-ptr!] ;const GUID __RPC_FAR *
	nCmdID [integer!]
	return: [integer!]
][ S_FALSE ]
UI_GetOptionKeyPath: func [
	[callback] this [this!]
	pchKey [int-ptr!] ;LPOLESTR __RPC_FAR *
	dw [integer!]
	return: [integer!]
][ S_FALSE ]
UI_GetDropTarget: func [
	[callback] this [this!]
	pDropTarget [int-ptr!] ;IDropTarget __RPC_FAR *
	ppDropTarget [int-ptr!] ;IDropTarget __RPC_FAR *__RPC_FAR *
	return: [integer!]
][ S_FALSE ]
UI_GetExternal: func [
	[callback] this [this!]
	ppDispatch [int-ptr!] ;IDispatch __RPC_FAR *__RPC_FAR *
	return: [integer!]
][
	ppDispatch/value: 0
	S_FALSE
]
UI_TranslateUrl: func [
	[callback] this [this!]
	dwTranslate [integer!]
	pchURLIn [int-ptr!] ;OLECHAR __RPC_FAR *
	ppchURLOut [int-ptr!] ;OLECHAR __RPC_FAR *__RPC_FAR *
	return: [integer!]
][
	ppchURLOut/value: 0
	S_FALSE
]
UI_FilterDataObject: func [
	[callback] this [this!]
	pDO [int-ptr!] ;IDataObject __RPC_FAR *
	ppDORet [int-ptr!] ;IDataObject __RPC_FAR *__RPC_FAR *
	return: [integer!]
][
	ppDORet/value: 0
	S_FALSE
]

MyIDocHostUIHandler: declare IDocHostUIHandler!

MyIDocHostUIHandler/QueryInterface:           :UI_QueryInterface
MyIDocHostUIHandler/AddRef:                   :UI_AddRef
MyIDocHostUIHandler/Release:                  :UI_Release
MyIDocHostUIHandler/ShowContextMenu:          :UI_ShowContextMenu
MyIDocHostUIHandler/GetHostInfo:              :UI_GetHostInfo
MyIDocHostUIHandler/ShowUI:                   :UI_ShowUI
MyIDocHostUIHandler/HideUI:                   :UI_HideUI
MyIDocHostUIHandler/UpdateUI:                 :UI_UpdateUI
MyIDocHostUIHandler/EnableModeless:           :UI_EnableModeless
MyIDocHostUIHandler/OnDocWindowActivate:      :UI_OnDocWindowActivate
MyIDocHostUIHandler/OnFrameWindowActivate:    :UI_OnFrameWindowActivate
MyIDocHostUIHandler/ResizeBorder:             :UI_ResizeBorder
MyIDocHostUIHandler/TranslateAccelerator:     :UI_TranslateAccelerator
MyIDocHostUIHandler/GetOptionKeyPath:         :UI_GetOptionKeyPath
MyIDocHostUIHandler/GetDropTarget:            :UI_GetDropTarget
MyIDocHostUIHandler/GetExternal:              :UI_GetExternal
MyIDocHostUIHandler/TranslateUrl:             :UI_TranslateUrl
MyIDocHostUIHandler/FilterDataObject:         :UI_FilterDataObject


;--////////////////////////////////////// My IOleClientSite functions  /////////////////////////////////////
;--// We give the browser object a pointer to our IOleClientSite object when we call OleCreate() or DoVerb().

Site_QueryInterface: func[
	[callback]
	this		[this!]
	riid		[int-ptr!]
	ppvObject	[interface!]
	return:		[integer!]
][
	;TRACE(["Site_QueryInterface-> this: " this " ppvObject: " ppvObject " ptr " ppvObject/ptr])
	case [
	 	any [
			IS_INTERFACE(riid IID_IUnknown)
			IS_INTERFACE(riid IID_IOleClientSite)
		][
			TRACE("client")
			ppvObject/ptr: this
		]
		IS_INTERFACE(riid IID_IOleInPlaceSite) [
			TRACE( ["inplace " ((as int-ptr! this) + 1) " " as int-ptr! (1 + this) ] )
			ppvObject/ptr: as this! ((as int-ptr! this) + 1)
			;dump-memory as byte-ptr! ppvObject 4 2
			;TRACE( "--------" )
		]
		IS_INTERFACE(riid IID_IDocHostUIHandler) [
			TRACE("ui")
			ppvObject/ptr: as this! ((as int-ptr! this) + 3)
		]
	;	IS_INTERFACE(riid IID_IServiceProvider) [
	;		TRACE("service")
	;		ppvObject/ptr: as this! ((as int-ptr! this) + 6)
	;	]
		true [
			;TRACE(["Unknown interface request: " iid-to-str riid])
			;dump-memory as byte-ptr! riid 4 1
			;TRACE( "          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
			ppvObject/ptr: as this! 0
			return E_NOINTERFACE
		]
	]
	S_OK
]
Site_AddRef: func [[callback] this [this!] return: [integer!]][ 1 ]
Site_Release: func [[callback] this [this!] return: [integer!]][ 1 ]
Site_SaveObject: func [[callback] this [this!] return: [integer!]][ NOTIMPLEMENTED ]
Site_GetMoniker: func [[callback] this [this!] dwAssign [integer!] dwWhichMoniker [integer!] ppmk [int-ptr!] return: [integer!]][ NOTIMPLEMENTED ]
Site_GetContainer: func [[callback] this [this!] ppContainer [int-ptr!] return: [integer!]][
	TRACE( "Site_GetContainer" )
	ppContainer/value: 0
	E_NOINTERFACE
]
Site_ShowObject: func [[callback] this [this!] return: [integer!]][ 0 ]
Site_OnShowWindow: func [[callback] this [this!] fShow [logic!] return: [integer!]][ NOTIMPLEMENTED ]
Site_RequestNewObjectLayout: func [[callback] this [this!] return: [integer!]][ NOTIMPLEMENTED ]


MyIOleClientSite: declare IOleClientSite!

MyIOleClientSite/QueryInterface:         :Site_QueryInterface
MyIOleClientSite/AddRef:                 :Site_AddRef
MyIOleClientSite/Release:                :Site_Release
MyIOleClientSite/SaveObject:             :Site_SaveObject
MyIOleClientSite/GetMoniker:             :Site_GetMoniker
MyIOleClientSite/GetContainer:           :Site_GetContainer
MyIOleClientSite/ShowObject:             :Site_ShowObject
MyIOleClientSite/OnShowWindow:           :Site_OnShowWindow
MyIOleClientSite/RequestNewObjectLayout: :Site_RequestNewObjectLayout



;--////////////////////////////////////// My IOleInPlaceSite functions  /////////////////////////////////////
;--// The browser object asks us for the pointer to our IOleInPlaceSite object by calling our IOleClientSite's
;--// QueryInterface (ie, Site_QueryInterface) and specifying a REFIID of IID_IOleInPlaceSite.

InPlace_QueryInterface: func[
	[callback] 
	this		[this!]
	riid		[int-ptr!]
	ppvObject	[interface!]
	return:		[integer!]
	/local
		ptr [int-ptr!]
][
	TRACE(["InPlace_QueryInterface " this])
	Site_QueryInterface 
		as this! ((as int-ptr! this) - 1)
		riid
		ppvObject
]
InPlace_AddRef: func [[callback] this [this!] return: [integer!]][ 1 ]
InPlace_Release: func [[callback] this [this!] return: [integer!]][ 2 ]
InPlace_GetWindow: func [
	[callback] 
	this   [this!]
	lphwnd [int-ptr!]         ;HWND FAR* 
	return: [integer!]
	/local
		ptr [int-ptr!]
][
	ptr: ((as int-ptr! this) - 2)
	TRACE(["InPlace_GetWindow " this  " " ptr ])
	;dump-hex4  as int-ptr! this
	lphwnd/value: ptr/value
	TRACE([as int-ptr! lphwnd/value])
	S_OK
]
InPlace_ContextSensitiveHelp: func [
	[callback] 
	this   [this!]
	fEnterMode [logic!]       ;BOOL
	return: [integer!]
][ NOTIMPLEMENTED ]
InPlace_CanInPlaceActivate: func [
	[callback] 
	this [this!]
	return: [integer!]
][ S_OK ]
InPlace_OnInPlaceActivate: func [
	[callback] 
	this [this!]
	return: [integer!]
][ S_OK ]
InPlace_OnUIActivate: func [
	[callback] 
	this [this!]
	return: [integer!]
][ S_OK ]
InPlace_GetWindowContext: func [
	[callback] 
	this [this!]
	lplpFrame [int-ptr!] ;LPOLEINPLACEFRAME FAR* 
	lplpDoc [int-ptr!] ;LPOLEINPLACEUIWINDOW FAR* 
	lprcPosRect  [LPRECT!]
	lprcClipRect [LPRECT!]
	lpFrameInfo  [tagOIFI!] ;LPOLEINPLACEFRAMEINFO
	return: [integer!]
	/local
		ptr [int-ptr!]
][
	TRACE(["InPlace_GetWindowContext " this])
	ptr: ((as int-ptr! this) + 1)

	lplpFrame/value: as integer! ptr

	TRACE(["lplpFrame: " as int-ptr! ptr/value])

	;// We have no OLEINPLACEUIWINDOW
	lplpDoc/value: 0

	ptr: ((as int-ptr! this) + 4)

	TRACE(["hwndFrame " ptr " " as int-ptr! ptr/value])

	;// Fill in some other info for the browser
	lpFrameInfo/fMDIApp: false
	lpFrameInfo/hwndFrame: as int-ptr! ptr/value
	lpFrameInfo/haccel: null
	lpFrameInfo/cAccelEntries: 0

	S_OK
]
InPlace_Scroll: func [
	[callback] 
	this [this!]
	scrollExtent [SIZE!]
	return: [integer!]
][ NOTIMPLEMENTED ]
InPlace_OnUIDeactivate: func [
	[callback] 
	this [this!]
	fUndoable [logic!]
	return: [integer!]
][ S_OK ]
InPlace_OnInPlaceDeactivate: func [
	[callback] 
	this [this!]
	return: [integer!]
][ S_OK ]
InPlace_DiscardUndoState: func [
	[callback] 
	this [this!]
	return: [integer!]
][ NOTIMPLEMENTED ]
InPlace_DeactivateAndUndo: func [
	[callback] 
	this [this!]
	return: [integer!]
][ NOTIMPLEMENTED ]
InPlace_OnPosRectChange: func [
;// Called when the position of the browser object is changed, such as when we call the IWebBrowser2's put_Width(),
;// put_Height(), put_Left(), or put_Right().
	[callback] 
	this [this!]
	lprcPosRect [LPCRECT!]
	return: [integer!]
	/local
		browser       [BrowserImpl!]
		browserObject [interface!]
		iObject       [IOleObject!]
		inplace       [IOleInPlaceObject!]
		ptr           [int-ptr!]
		IH            [interface!]
		hr            [integer!]
][
	TRACE(["InPlace_OnPosRectChange " this])
	browser: as BrowserImpl! ((as int-ptr! this) - 3)
	browserObject: browser/object
	iObject: as IOleObject! browserObject/ptr/vtbl
	IH: declare interface!
	hr: iObject/QueryInterface AS_THIS(browserObject) IID_IOleInPlaceObject IH
	if hr = 0 [
		inplace: as IOleInPlaceObject! IH/ptr/vtbl
		inplace/SetObjectRects AS_THIS(IH) lprcPosRect lprcPosRect
		inplace/Release AS_THIS(IH)
	]
	S_OK
]

MyIOleInPlaceSite: declare IOleInPlaceSite!

MyIOleInPlaceSite/QueryInterface:             :InPlace_QueryInterface
MyIOleInPlaceSite/AddRef:                     :InPlace_AddRef
MyIOleInPlaceSite/Release:                    :InPlace_Release
MyIOleInPlaceSite/GetWindow:                  :InPlace_GetWindow
MyIOleInPlaceSite/ContextSensitiveHelp:       :InPlace_ContextSensitiveHelp
MyIOleInPlaceSite/CanInPlaceActivate:         :InPlace_CanInPlaceActivate
MyIOleInPlaceSite/OnInPlaceActivate:          :InPlace_OnInPlaceActivate
MyIOleInPlaceSite/OnUIActivate:               :InPlace_OnUIActivate
MyIOleInPlaceSite/GetWindowContext:           :InPlace_GetWindowContext
MyIOleInPlaceSite/Scroll:                     :InPlace_Scroll
MyIOleInPlaceSite/OnUIDeactivate:             :InPlace_OnUIDeactivate
MyIOleInPlaceSite/OnInPlaceDeactivate:        :InPlace_OnInPlaceDeactivate
MyIOleInPlaceSite/DiscardUndoState:           :InPlace_DiscardUndoState
MyIOleInPlaceSite/DeactivateAndUndo:          :InPlace_DeactivateAndUndo
MyIOleInPlaceSite/OnPosRectChange:            :InPlace_OnPosRectChange


;--////////////////////////////////////// My IOleInPlaceFrame functions  /////////////////////////////////////////

Frame_QueryInterface: func[
	[callback] 
	this		[this!]
	riid		[int-ptr!]
	ppvObject	[interface!]
	return:		[integer!]
	/local
		ptr [int-ptr!]
][
	NOTIMPLEMENTED
]
Frame_AddRef: func [[callback] this [this!] return: [integer!]][ 1 ]
Frame_Release: func [[callback] this [this!] return: [integer!]][ 1 ]
Frame_GetWindow: func [
	[callback] 
	this   [this!]
	lphwnd [int-ptr!]         ;HWND FAR* 
	return: [integer!]
	/local
		ptr [int-ptr!]
][
	TRACE( ["Frame_GetWindow " this] )
	ptr: (as int-ptr! this) - 3
	lphwnd/value: ptr/value
	TRACE( ["lphwnd/value: " HEXA(lphwnd/value)] )
	S_OK
]
Frame_ContextSensitiveHelp: func [
	[callback] 
	this   [this!]
	fEnterMode [logic!]       ;BOOL
	return: [integer!]
][ NOTIMPLEMENTED ]
Frame_GetBorder: func [
	[callback] 
	this   [this!]
	lprectBorder [LPRECT!]
	return: [integer!]
][ NOTIMPLEMENTED ]
Frame_RequestBorderSpace: func [
	[callback] 
	this   [this!]
	pborderwidths [LPCBORDERWIDTHS!]
	return: [integer!]
][ NOTIMPLEMENTED ]
Frame_SetBorderSpace: func [
	[callback] 
	this   [this!]
	pborderwidths [LPCBORDERWIDTHS!]
	return: [integer!]
][ NOTIMPLEMENTED ]
Frame_SetActiveObject: func [
	[callback] 
	this   [this!]
	pActiveObject [int-ptr!]  ;IOleInPlaceActiveObject *
	pszObjName [int-ptr!]     ;LPCOLESTR
	return: [integer!]
][ S_OK ]
Frame_InsertMenus: func [
	[callback] 
	this   [this!]
	hmenuShared [int-ptr!] ;HMENU
	lpMenuWidths [int-ptr!] ;LPOLEMENUGROUPWIDTHS 
	return: [integer!]
][ NOTIMPLEMENTED ]
Frame_SetMenu: func [
	[callback] 
	this   [this!]
	hmenuShared [int-ptr!] ;HMENU
	holemenu [int-ptr!] ;HOLEMENU
	hwndActiveObject [int-ptr!] ;HWND 
	return: [integer!]
][ S_OK ]
Frame_RemoveMenus: func [
	[callback] 
	this   [this!]
	hmenuShared [int-ptr!] ;HMENU
	return: [integer!]
][ NOTIMPLEMENTED ]
Frame_SetStatusText: func [
	[callback] 
	this   [this!]
	pszStatusText [int-ptr!] ;LPCOLESTR
	return: [integer!]
][ S_OK ]
Frame_EnableModeless: func [
	[callback] 
	this   [this!]
	fEnable [logic!]
	return: [integer!]
][ S_OK ]
Frame_TranslateAccelerator: func [
	[callback] 
	this   [this!]
	lpmsg  [LPMSG!]
	wID    [integer!] ;@@ SHOULD BE WORD
	return: [integer!]
][ NOTIMPLEMENTED ]

MyIOleInPlaceFrame: declare IOleInPlaceFrame!

MyIOleInPlaceFrame/QueryInterface:        :Frame_QueryInterface
MyIOleInPlaceFrame/AddRef:                :Frame_AddRef
MyIOleInPlaceFrame/Release:               :Frame_Release
MyIOleInPlaceFrame/GetWindow:             :Frame_GetWindow
MyIOleInPlaceFrame/ContextSensitiveHelp:  :Frame_ContextSensitiveHelp
MyIOleInPlaceFrame/GetBorder:             :Frame_GetBorder
MyIOleInPlaceFrame/RequestBorderSpace:    :Frame_RequestBorderSpace
MyIOleInPlaceFrame/SetBorderSpace:        :Frame_SetBorderSpace
MyIOleInPlaceFrame/SetActiveObject:       :Frame_SetActiveObject
MyIOleInPlaceFrame/InsertMenus:           :Frame_InsertMenus
MyIOleInPlaceFrame/SetMenu:               :Frame_SetMenu
MyIOleInPlaceFrame/RemoveMenus:           :Frame_RemoveMenus
MyIOleInPlaceFrame/SetStatusText:         :Frame_SetStatusText
MyIOleInPlaceFrame/EnableModeless:        :Frame_EnableModeless
MyIOleInPlaceFrame/TranslateAccelerator:  :Frame_TranslateAccelerator


;@@TODO: void UnEmbedBrowserObject(HWND hwnd)

#define WEBPAGE_GOBACK		0
#define WEBPAGE_GOFORWARD	1
#define WEBPAGE_GOHOME		2
#define WEBPAGE_SEARCH		3
#define WEBPAGE_REFRESH		4
#define WEBPAGE_STOP		5

;@@TODO: void DoPageAction(HWND hwnd, DWORD action)

DisplayHTMLStr: func[
	hwnd   [int-ptr!]
	string [c-string!]
	return: [integer!]
	/local
		hr            [integer!]
		browser       [BrowserImpl!]
		iWebBrowser2  [interface!]
		webBrowser2   [IWebBrowser2!]
		iObject       [IOleObject!]
		iDispatch     [IDispatch!]
		var           [tagVARIANT]
		lpDispatch    [interface!]
		iHtmlDoc2     [interface!]
		htmlDoc2      [IHTMLDocument2!]
		sfArray       [int-ptr!]
		pVar          [int-ptr!]
][
	TRACE( "^/== DisplayHTMLStr ==" )
	iWebBrowser2: declare interface!
	iHtmlDoc2: declare interface!
	lpDispatch: declare interface!
	sfArray: declare int-ptr! 0
	pVar: declare int-ptr!

	browser: as BrowserImpl! GetWindowLong hWnd GWL_USERDATA
	iObject: as IOleObject! browser/object/ptr/vtbl
	TRACE( ["browserObject: " iObject " " browser/object/ptr] )
	if 0 = iObject/QueryInterface browser/object/ptr IID_IWebBrowser2 iWebBrowser2 [
		webBrowser2: as IWebBrowser2! iWebBrowser2/ptr/vtbl
		TRACE( ["webBrowser2: " webBrowser2] )
		var: declare tagVARIANT
		VariantInit var
		var/data1: VT_BSTR
		var/data3: as-integer SysAllocString #u16 "about:blank"

		hr: webBrowser2/Navigate2 AS_THIS(iWebBrowser2) var null null null null
		TRACE( ["webBrowser2/Navigate2 " hr] )

		VariantClear var

		;// Call the IWebBrowser2 object's get_Document so we can get its DISPATCH object. I don't know why you
		;// don't get the DISPATCH object via the browser object's QueryInterface(), but you don't.
		if 0 = webBrowser2/get_Document AS_THIS(iWebBrowser2) lpDispatch [
			TRACE( ["lpDispatch: " lpDispatch] )
			;// We want to get a pointer to the IHTMLDocument2 object embedded within the DISPATCH
			;// object, so we can call some of the functions in the former's table.
			iDispatch: as IDispatch! lpDispatch/ptr/vtbl
			if 0 = iDispatch/QueryInterface AS_THIS(lpDispatch) IID_IHTMLDocument2 iHtmlDoc2 [
				TRACE( ["iHtmlDoc2: " iHtmlDoc2] )
				htmlDoc2: as IHTMLDocument2! iHtmlDoc2/ptr/vtbl
				;// Our HTML must be in the form of a BSTR. And it must be passed to write() in an
				;// array of "VARIENT" structs. So let's create all that.

				sfArray: SafeArrayCreate VT_VARIANT 1 ArrayBound
				TRACE( ["sfArray: " sfArray ] )
				if null <> sfArray [
					if 0 = SafeArrayAccessData as integer! sfArray pVar [
						var: as tagVARIANT pVar/value
						var/data1: VT_BSTR
						var/data3: as-integer SysAllocString string
						if 0 <> var/data3 [
							;// Pass the VARIENT with its BSTR to write() in order to shove our desired HTML string
							;// into the body of that empty page we created above.
							hr: htmlDoc2/write AS_THIS(iHtmlDoc2) sfArray
							TRACE( ["htmlDoc2/write: " hr] )

							;// Close the document. If we don't do this, subsequent calls to DisplayHTMLStr
							;// would append to the current contents of the page
							hr: htmlDoc2/close AS_THIS(iHtmlDoc2)
							TRACE( ["htmlDoc2/close: " hr] )
							
							;// Normally, we'd need to free our BSTR, but SafeArrayDestroy() does it for us
						]
					]
					;// Free the array. This also frees the VARIENT that SafeArrayAccessData created for us,
					;// and even frees the BSTR we allocated with SysAllocString
					;SafeArrayDestroy as integer! sfArray
				]
				;// Release the IHTMLDocument2 object.

				htmlDoc2/Release AS_THIS(iHtmlDoc2)
			]
			;// Release the DISPATCH object.
			iDispatch/Release AS_THIS(lpDispatch)
		]
		;// Release the IWebBrowser2 object.
		webBrowser2/Release AS_THIS(iWebBrowser2)
	]
	0
]

DisplayHTMLPage: func[
	hwnd   [int-ptr!]
	url    [c-string!]
	return: [integer!]
	/local
		hr            [integer!]
		browser       [BrowserImpl!]
		iWebBrowser2  [interface!]
		webBrowser2   [IWebBrowser2!]
		iObject       [IOleObject!]
		var           [tagVARIANT]
][
	TRACE( "^/== DisplayHTMLPage ==" )
	iWebBrowser2: declare interface!
	browser: as BrowserImpl! GetWindowLong hWnd GWL_USERDATA
	iObject: as IOleObject! browser/object/ptr/vtbl
	TRACE( ["browserObject: " iObject " " browser/object/ptr] )
	if 0 = iObject/QueryInterface browser/object/ptr IID_IWebBrowser2 iWebBrowser2 [
		webBrowser2: as IWebBrowser2! iWebBrowser2/ptr/vtbl
		TRACE( ["webBrowser2: " webBrowser2] )
		var: declare tagVARIANT
		VariantInit var
		var/data1: VT_BSTR
		var/data3: as-integer SysAllocString url

		hr: webBrowser2/Navigate2 AS_THIS(iWebBrowser2) var null null null null
		TRACE( ["webBrowser2/Navigate2 " hr] )

		VariantClear var
		
		;// Release the IWebBrowser2 object.
		webBrowser2/Release AS_THIS(iWebBrowser2)
	]
	0
]

ResizeBrowser: func[
	hwnd    [int-ptr!]
	width   [integer!]
	height  [integer!]
	/local
		hr            [integer!]
		browser       [BrowserImpl!]
		iWebBrowser2  [interface!]
		webBrowser2   [IWebBrowser2!]
		iObject       [IOleObject!]

][
	TRACE( ["^/== ResizeBrowser ==" hWnd] )
	iWebBrowser2: declare interface!
	browser: as BrowserImpl! GetWindowLong hWnd GWL_USERDATA
	iObject: as IOleObject! browser/object/ptr/vtbl
	TRACE( ["browserObject: " iObject " " browser/object/ptr] )
	if 0 = iObject/QueryInterface browser/object/ptr IID_IWebBrowser2 iWebBrowser2 [
		webBrowser2: as IWebBrowser2! iWebBrowser2/ptr/vtbl
		TRACE( ["webBrowser2: " webBrowser2] )
		webBrowser2/put_Width AS_THIS(iWebBrowser2) width
		webBrowser2/put_Height AS_THIS(iWebBrowser2) height
		webBrowser2/Release AS_THIS(iWebBrowser2)
	]
]
EmbedBrowserObject: func[
	hwnd [int-ptr!]
	return: [integer!]
	/local
		hr [integer!]
		browser [BrowserImpl!]
		browserObject [interface!]
		iBrowser [interface!]
		ptr [handle!]
		IH [interface!]
		webBrowser2 [IWebBrowser2!]
		iObject [IOleObject!]
		factory [IClassFactory!] 
		status [integer!]
		size [integer!]
		rc [RECT_STRUCT]
][
	ptr: GlobalAlloc 40h (size? BrowserImpl!)

	TRACE( ["ptr: " ptr " size: " (size? BrowserImpl!) " hwnd: " hwnd ])

	IH: declare interface!
	
	TRACE( ["pClassFactory: " IH] )

	browserObject: as interface! GlobalAlloc 40h (size? interface!)

	browser: as BrowserImpl! ptr
	browser/object: browserObject
	browser/window:  hwnd
	browser/client:  MyIOleClientSite
	browser/inplace: MyIOleInPlaceSite
	browser/frame:   MyIOleInPlaceFrame
	browser/ui:      MyIDocHostUIHandler
	browser/service: MyIServiceProvider

	hr: CoGetClassObject CLSID_WebBrowser (CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER) null IID_IClassFactory IH
	;TRACE( ["CoGetClassObject-> " as int-ptr! hr " " IH/ptr " " as int-ptr! IH/ptr/vtbl] )

	if all [0 = hr 0 <> as integer! IH/ptr][
		;if (!pClassFactory->lpVtbl->CreateInstance(pClassFactory, 0, &IID_IOleObject, &browserObject))
		factory: as IClassFactory! IH/ptr/vtbl
		hr: factory/CreateInstance IH/ptr null IID_IOleObject browserObject
		TRACE( ["CreateInstance-> " hr " " factory " " browser/object " " browserObject] )

		#if debug? = yes [print "PTR:" dump-hex4  ptr]

		TRACE( "----------------------------------------------------------" )
		TRACE( ["BrowserObject:       " ptr     " " browser/object] )
		TRACE( ["Window:              " ptr + 1 " " browser/window " " hWnd] )
		TRACE( ["MyIOleClientSite:    " ptr + 2 " " MyIOleClientSite ] )
		TRACE( ["MyIOleInPlaceSite:   " ptr + 3 " " MyIOleInPlaceSite ] )
		TRACE( ["MyIOleInPlaceFrame:  " ptr + 4 " " MyIOleInPlaceFrame ] )
		TRACE( ["MyIDocHostUIHandler: " ptr + 5 " " MyIDocHostUIHandler ] )
		TRACE( ["MyIServiceProvider:  " ptr + 6 " " MyIServiceProvider] )
		TRACE( "----------------------------------------------------------" )
		
		if all [0 = hr 0 <> as integer! IH/ptr][
			hr: factory/Release IH/ptr
			TRACE( ["Release-> " hr] )

			SetWindowLong hwnd GWL_USERDATA as integer! browser

			;// Give the browser a pointer to my IOleClientSite object
			iObject: as IOleObject! browserObject/ptr/vtbl
			TRACE(["iObject: " iObject " ======================= " AS_THIS(browserObject)]) 
			;status: 0
            ;hr: iObject/GetMiscStatus AS_THIS(browserObject) 1 :status
            ;TRACE( ["GetMiscStatus: " hr " " HEXA(status)] )

			hr: iObject/SetClientSite AS_THIS(browserObject) (ptr + 2)
			TRACE( ["SetClientSite " hr] )

			if 0 = hr [
				hr: iObject/SetHostNames as this! browser #u16 "My Host Name" null
				TRACE( ["SetHostNames: " hr " == " browserObject " " AS_THIS(browserObject)] )

				rc:  declare RECT_STRUCT [0 0 0 0]
				GetClientRect hWnd rc
				TRACE( ["Rect: " hr " " rc/left "x" rc/top " " rc/right "x" rc/bottom] )

				if all [
					0 = OleSetContainedObject AS_THIS(browserObject) true
					0 = iObject/DoVerb AS_THIS(browserObject) OLEIVERB_SHOW null (ptr + 2) 0 hWnd rc
					0 = iObject/QueryInterface AS_THIS(browserObject) IID_IWebBrowser2 IH
				][
					webBrowser2: as IWebBrowser2! IH/ptr/vtbl
					webBrowser2/put_Left AS_THIS(IH) 0
					webBrowser2/put_Top AS_THIS(IH) 0
					webBrowser2/put_Width AS_THIS(IH) rc/right
					webBrowser2/put_Height AS_THIS(IH) rc/bottom

					;// We no longer need the IWebBrowser2 object (ie, we don't plan to call any more functions in it
					;// right now, so we can release our hold on it). Note that we'll still maintain our hold on the
					;// browser object until we're done with that object.
					webBrowser2/Release AS_THIS(IH)
					return 0
				]
			]
			;// Something went wrong setting up the browser!
			;UnEmbedBrowserObject(hwnd);
			return -4
		]
	]
	0
]

#either modules contains 'View [

	browser: symbol/make "browser"

	BrowserWndProc: func [
	    hWnd        [handle!]
	    msg            [integer!]
	    wParam        [integer!]
	    lParam        [integer!]
	    return: [integer!]
	] [
		TRACE( ["BrowserWndProc: " msg " hWnd: " hWnd] )
	    switch msg [
	  		5 [;size
				ResizeBrowser hWnd WIN32_LOWORD(lParam) WIN32_HIWORD(lParam)
				return 0
			]
	    	1 [;create
				if 0 <> EmbedBrowserObject hWnd [ return -1 ]
				DisplayHTMLPage hWnd #u16 "file:///X:/GIT/Red/boot.red"
			]
			WM_DESTROY [
				print-line "destroy"
			]
	        default []
	    ]
	    DefWindowProc hWnd msg wParam lParam
	]

	wcex: declare WNDCLASSEX

	wcex/cbSize: 		size? WNDCLASSEX
	wcex/hInstance:		hInstance
	wcex/lpszClassName: #u16 "RedBrowser"
	wcex/lpfnWndProc:	:BrowserWndProc
	
	RegisterClassEx wcex

	gui/register-class [                    ;-- returns old events handler
	    #u16 "RedBrowser"                   ;-- widget original name
	    null                                ;-- new internal name
	    symbol/make "browser"               ;-- Red-level style name
	    0                                   ;-- exStyle flags
	    0                                   ;-- style flags
	    0                                   ;-- base ID for instances
	    null                                ;-- style custom event handler
	    null                                ;-- parent custom event handler
	]

][
	;-- STAND ALONE VERSION - opens own windowand event loop
	WndProc: func [
		hWnd	[handle!]
		msg		[integer!]
		wParam	[integer!]
		lParam	[integer!]
		return: [integer!]
	][
		;TRACE( ["WinProc: " msg " hWnd: " hWnd] )
		switch msg [
			5 [;size
				ResizeBrowser hWnd WIN32_LOWORD(lParam) WIN32_HIWORD(lParam)
				return 0
			]
			1 [;create
				if 0 <> EmbedBrowserObject hWnd [
					return -1
				]
			]
			2 [;destroy
				PostQuitMessage 0
				return 1
			]
			default [
			]
		]
		DefWindowProc hWnd msg wParam lParam
	]
	init: func [
		/local
			wcex    [WNDCLASSEX]
			class   [c-string!]
			handle  [int-ptr!]
			msg     [tagMSG]
			hWnd    [handle!]
	][
		hInstance: GetModuleHandle 0
		class: #u16 "RedBrowser"

		msg: declare tagMSG

		if 0 = OleInitialize null [
			TRACE( "initwindow" )
			wcex: declare WNDCLASSEX

			wcex/cbSize: 		size? WNDCLASSEX
			wcex/hInstance:		hInstance
			wcex/lpszClassName: class
			wcex/lpfnWndProc:	:WndProc
			
			RegisterClassEx wcex

			hWnd: CreateWindowEx
				0
				class
				#u16 "Browser object test"
				WS_OVERLAPPEDWINDOW
				0 0	1024	500
				null ;HWND_DESKTOP
				null
				hInstance
				null
			if null <> hWnd [
				;DisplayHTMLStr hWnd #u16 "<BODY><H2><CENTER>HTML string test</CENTER></H2><P><FONT COLOR=RED>This is a <U>HTML string</U> in memory.</FONT></BODY>"
				DisplayHTMLPage hWnd #u16 "file:///X:/GIT/Red/boot.red" ;"http://google.com" ;"http://red-lang.org" ;"https://gitter.im/red/red"
				;// Show the window.
				ShowWindow hWnd SW_SHOWDEFAULT
				UpdateWindow hWnd
			]

			TRACE( ["WINDOW hWnd:" hWnd] )
			msg/hWnd: hWnd
			while [1 = GetMessage msg null 0 0][
				TranslateMessage msg
				DispatchMessage msg
			]

			;// Free the OLE library.
			OleUninitialize
		]
	]

	CoInitializeEx 0 COINIT_APARTMENTTHREADED

	init
]
