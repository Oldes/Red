Red/System [
	Title:	"IOleObject interface"
	Author: "Oldes"
	File: 	%IOleObject.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IOleObject: [00000112h 00000000h 000000C0h 46000000h]

IOleObject!: alias struct! [
	QueryInterface       [QueryInterface!]
	AddRef               [AddRef!]
	Release              [Release!]
    SetClientSite        [function! [[callback] this [this!] pClientSite [int-ptr!] return: [integer!]]] ;[in, unique] IOleClientSite *pClientSite);
	GetClientSite        [function! [[callback] this [this!] ppClientSite [interface!] return: [integer!]]] ;[out] IOleClientSite **ppClientSite);
	SetHostNames         [function! [[callback] this [this!] szContainerApp [c-string!] szContainerObj [int-ptr!] return: [integer!]]] ;[in] LPCOLESTR szContainerApp,[in, unique] LPCOLESTR szContainerObj);
	Close                [integer!] ;[in] DWORD dwSaveOption);
	SetMoniker           [integer!] ;[in] DWORD dwWhichMoniker,[in, unique] IMoniker *pmk);
	GetMoniker           [integer!] ;[in] DWORD dwAssign,[in] DWORD dwWhichMoniker,[out] IMoniker **ppmk);
	InitFromData         [integer!] ;[in, unique] IDataObject *pDataObject,[in] BOOL fCreation,[in] DWORD dwReserved);
	GetClipboardData     [integer!] ;[in] DWORD dwReserved,[out] IDataObject **ppDataObject);
	DoVerb               [function! [[callback] this [this!] iVerb [integer!] lpmsg [tagMSG] pActiveSite [int-ptr!] lindex [integer!] hwndParent [handle!] lprcPosRect [LPRECT!] return: [integer!]]] ;[in] LONG iVerb,[in, unique] LPMSG lpmsg,[in, unique] IOleClientSite *pActiveSite,[in] LONG lindex,[in] HWND hwndParent,[in, unique] LPCRECT lprcPosRect);
	EnumVerbs            [integer!] ;[out] IEnumOLEVERB **ppEnumOleVerb);
	Update               [integer!] ;
	IsUpToDate           [integer!] ;
	GetUserClassID       [integer!] ;[out] CLSID *pClsid);
	GetUserType          [integer!] ;[in] DWORD dwFormOfType,[out] LPOLESTR *pszUserType);
	SetExtent            [integer!] ;[in] DWORD dwDrawAspect,[in] SIZEL *psizel);
	GetExtent            [integer!] ;[in] DWORD dwDrawAspect,[out] SIZEL *psizel);
	Advise               [integer!] ;[in, unique] IAdviseSink *pAdvSink,[out] DWORD *pdwConnection);
	Unadvise             [integer!] ;[in] DWORD dwConnection);
	EnumAdvise           [integer!] ;[out] IEnumSTATDATA **ppenumAdvise);
	GetMiscStatus        [function! [[callback] this [this!] dwAspect [integer!] pdwStatus [int-ptr!] return: [integer!]]] ;[in] DWORD dwAspect,[out] DWORD *pdwStatus);
	SetColorScheme       [integer!] ;[in] LOGPALETTE *pLogpal);
]