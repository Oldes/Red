Red/System [
	Title:	"IDocHostUIHandler interface"
	Author: "Oldes"
	File: 	%IDocHostUIHandler.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IDocHostUIHandler: [BD3F23C0h 11CFD43Eh AA003B89h 1ACEBD00h]

;-- Our IDocHostUIHandler functions that the browser may call
UI_ShowContextMenu!: alias function! [[callback] 
	this [this!]
	dwID [integer!]
	ppt [POINT!]
	pcmdtReserved [int-ptr!] ;IUnknown __RPC_FAR *
	pdispReserved [int-ptr!] ;IDispatch __RPC_FAR *
	return: [integer!]
]
UI_GetHostInfo!: alias function! [[callback] 
	this [this!] 
	pInfo [int-ptr!] ;DOCHOSTUIINFO __RPC_FAR *
	return: [integer!]
]
UI_ShowUI!: alias function! [[callback] 
	this [this!]
	dwID [integer!]
	pActiveObject [int-ptr!] ;IOleInPlaceActiveObject __RPC_FAR *
	pCommandTarget [int-ptr!] ;IOleCommandTarget __RPC_FAR *
	pFrame [int-ptr!] ;IOleInPlaceFrame __RPC_FAR *
	pDoc [int-ptr!] ;IOleInPlaceUIWindow __RPC_FAR *
	return: [integer!]
]
UI_HideUI!: alias function! [[callback] this [this!] return: [integer!]]
UI_UpdateUI!: alias function! [[callback] this [this!] return: [integer!]]
UI_EnableModeless!: alias function! [[callback] this [this!] fEnable [logic!] return: [integer!]]
UI_OnDocWindowActivate!: alias function! [[callback] this [this!] fActivate [logic!] return: [integer!]]
UI_OnFrameWindowActivate!: alias function! [[callback] this [this!] fActivate [logic!] return: [integer!]]
UI_ResizeBorder!: alias function! [[callback] 
	this [this!]
	prcBorder [LPCRECT!]
	pUIWindow [int-ptr!] ;IOleInPlaceUIWindow __RPC_FAR *
	fRameWindow [logic!]
	return: [integer!]
]
UI_TranslateAccelerator!: alias function! [[callback] 
	this [this!]
	lpMsg [LPMSG!]
	pguidCmdGroup [int-ptr!] ;const GUID __RPC_FAR *
	nCmdID [integer!]
	return: [integer!]
]
UI_GetOptionKeyPath!: alias function! [[callback] 
	this [this!]
	pchKey [int-ptr!] ;LPOLESTR __RPC_FAR *
	dw [integer!]
	return: [integer!]
]
UI_GetDropTarget!: alias function! [[callback] 
	this [this!]
	pDropTarget [int-ptr!] ;IDropTarget __RPC_FAR *
	ppDropTarget [int-ptr!] ;IDropTarget __RPC_FAR *__RPC_FAR *
	return: [integer!]
]
UI_GetExternal!: alias function! [[callback] 
	this [this!]
	ppDispatch [int-ptr!] ;IDispatch __RPC_FAR *__RPC_FAR *
	return: [integer!]
]
UI_TranslateUrl!: alias function! [[callback] 
	this [this!]
	dwTranslate [integer!]
	pchURLIn [int-ptr!] ;OLECHAR __RPC_FAR *
	ppchURLOut [int-ptr!] ;OLECHAR __RPC_FAR *__RPC_FAR *
	return: [integer!]
]
UI_FilterDataObject!: alias function! [[callback] 
	this [this!]
	pDO [int-ptr!] ;IDataObject __RPC_FAR *
	ppDORet [int-ptr!] ;IDataObject __RPC_FAR *__RPC_FAR *
	return: [integer!]
]

IDocHostUIHandler!: alias struct! [
	QueryInterface         [QueryInterface!]
	AddRef                 [AddRef!]
	Release                [Release!]
	ShowContextMenu        [UI_ShowContextMenu!]
	GetHostInfo            [UI_GetHostInfo!]
	ShowUI                 [UI_ShowUI!]
	HideUI                 [UI_HideUI!]
	UpdateUI               [UI_UpdateUI!]
	EnableModeless         [UI_EnableModeless!]
	OnDocWindowActivate    [UI_OnDocWindowActivate!]
	OnFrameWindowActivate  [UI_OnFrameWindowActivate!]
	ResizeBorder           [UI_ResizeBorder!]
	TranslateAccelerator   [UI_TranslateAccelerator!]
	GetOptionKeyPath       [UI_GetOptionKeyPath!]
	GetDropTarget          [UI_GetDropTarget!]
	GetExternal            [UI_GetExternal!]
	TranslateUrl           [UI_TranslateUrl!]
	FilterDataObject       [UI_FilterDataObject!]
]