Red/System [
	Title:	"IWebBrowser2 interface"
	Author: "Oldes"
	File: 	%IWebBrowser2.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IWebBrowser2: [D30C1661h 11D0CDAFh C0003E8Ah 6EE2C94Fh]

IWebBrowser2!: alias struct! [
	QueryInterface       [QueryInterface!]
	AddRef               [AddRef!]
	Release              [Release!]
	GetTypeInfoCount [function! [this [this!] value [int-ptr!] return: [integer!]]] ; /* [out] */ __RPC__out UINT *pctinfo);
    GetTypeInfo [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ UINT iTInfo,
    ;        /* [in] */ LCID lcid,
    ;        /* [out] */ __RPC__deref_out_opt ITypeInfo **ppTInfo);
    GetIDsOfNames [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ __RPC__in REFIID riid,
    ;        /* [size_is][in] */ __RPC__in_ecount_full(cNames) LPOLESTR *rgszNames,
    ;        /* [range][in] */ __RPC__in_range(0,16384) UINT cNames,
    ;        /* [in] */ LCID lcid,
    ;        /* [size_is][out] */ __RPC__out_ecount_full(cNames) DISPID *rgDispId);
    Invoke [integer!]
    ;        IWebBrowser2 * This,
    ;        /* [annotation][in] */ 
    ;        _In_  DISPID dispIdMember,
    ;        /* [annotation][in] */ 
    ;        _In_  REFIID riid,
    ;        /* [annotation][in] */ 
    ;        _In_  LCID lcid,
    ;        /* [annotation][in] */ 
    ;        _In_  WORD wFlags,
    ;        /* [annotation][out][in] */ 
    ;        _In_  DISPPARAMS *pDispParams,
    ;        /* [annotation][out] */ 
    ;        _Out_opt_  VARIANT *pVarResult,
    ;        /* [annotation][out] */ 
    ;        _Out_opt_  EXCEPINFO *pExcepInfo,
    ;        /* [annotation][out] */ 
    ;        _Out_opt_  UINT *puArgErr);
    GoBack [function! [this [this!] return: [integer!]]]
    GoForward [function! [this [this!] return: [integer!]]]
    GoHome [function! [this [this!] return: [integer!]]]
    GoSearch [function! [this [this!] return: [integer!]]]
    Navigate [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ __RPC__in BSTR URL,
    ;        /* [unique][optional][in] */ __RPC__in_opt VARIANT *Flags,
    ;        /* [unique][optional][in] */ __RPC__in_opt VARIANT *TargetFrameName,
    ;        /* [unique][optional][in] */ __RPC__in_opt VARIANT *PostData,
    ;        /* [unique][optional][in] */ __RPC__in_opt VARIANT *Headers);
    Refresh [function! [this [this!] return: [integer!]]] ;
    Refresh2 [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [unique][optional][in] */ __RPC__in_opt VARIANT *Level);
    Stop [function! [this [this!] return: [integer!]]] ;
    get_Application [function! [this [this!] ppDisp [interface!] return: [integer!]]]
    get_Parent [function! [this [this!] ppDisp [interface!] return: [integer!]]]
    get_Container [function! [this [this!] ppDisp [interface!] return: [integer!]]]
    get_Document [function! [this [this!] ppDisp [interface!] return: [integer!]]]
    get_TopLevelContainer [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pBool);
    get_Type [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__deref_out_opt BSTR *Type);
    get_Left [function! [this [this!] pl [int-ptr!] return: [integer!]]]
    put_Left [function! [this [this!] Left [integer!] return: [integer!]]]
    get_Top [function! [this [this!] pl [int-ptr!] return: [integer!]]]
    put_Top [function! [this [this!] Top [integer!] return: [integer!]]]
    get_Width [function! [this [this!] pl [int-ptr!] return: [integer!]]]
    put_Width [function! [this [this!] Width [integer!] return: [integer!]]]
    get_Height [function! [this [this!] pl [int-ptr!] return: [integer!]]]
    put_Height [function! [this [this!] Height [integer!] return: [integer!]]]
    get_LocationName [function! [this [this!] value [int-ptr!] return: [integer!]]] ; /* [retval][out] */ __RPC__deref_out_opt BSTR *LocationName);
    get_LocationURL [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__deref_out_opt BSTR *LocationURL);
    get_Busy [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pBool);
    Quit [function! [this [this!] return: [integer!]]] ;
    ClientToWindow [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [out][in] */ __RPC__inout int *pcx,
    ;        /* [out][in] */ __RPC__inout int *pcy);
    PutProperty [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ __RPC__in BSTR Property,
    ;        /* [in] */ VARIANT vtValue);
    GetProperty [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ __RPC__in BSTR Property,
    ;        /* [retval][out] */ __RPC__out VARIANT *pvtValue);
    get_Name [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__deref_out_opt BSTR *Name);
    get_HWND [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out SHANDLE_PTR *pHWND);
    get_FullName [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__deref_out_opt BSTR *FullName);
    get_Path [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__deref_out_opt BSTR *Path);
    get_Visible [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pBool);
    put_Visible [function! [this [this!] value [integer!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL Value);
    get_StatusBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pBool);
    put_StatusBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL Value);
    get_StatusText [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__deref_out_opt BSTR *StatusText);
    put_StatusText [function! [this [this!] value [c-string!] return: [integer!]]] ;/* [in] */ __RPC__in BSTR StatusText);
    get_ToolBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out int *Value);
    put_ToolBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ int Value);
    get_MenuBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *Value);
    put_MenuBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL Value);
    get_FullScreen [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pbFullScreen);
    put_FullScreen [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL bFullScreen);
    Navigate2 [function! [this [this!] url [tagVARIANT] Flags [int-ptr!] TargetFrameName [int-ptr!] PostData [int-ptr!] Headers [int-ptr!] return: [integer!]]]
    QueryStatusWB [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ OLECMDID cmdID,
    ;        /* [retval][out] */ __RPC__out OLECMDF *pcmdf);
    ExecWB [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ OLECMDID cmdID,
    ;        /* [in] */ OLECMDEXECOPT cmdexecopt,
    ;        /* [unique][optional][in] */ __RPC__in_opt VARIANT *pvaIn,
    ;        /* [unique][optional][out][in] */ __RPC__inout_opt VARIANT *pvaOut);
    ShowBrowserBar [integer!]
    ;        __RPC__in IWebBrowser2 * This,
    ;        /* [in] */ __RPC__in VARIANT *pvaClsid,
    ;        /* [unique][optional][in] */ __RPC__in_opt VARIANT *pvarShow,
    ;        /* [unique][optional][in] */ __RPC__in_opt VARIANT *pvarSize);
    get_ReadyState [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [out][retval] */ __RPC__out READYSTATE *plReadyState);
    get_Offline [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pbOffline);
    put_Offline [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL bOffline);
    get_Silent [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pbSilent);
    put_Silent [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL bSilent);
    get_RegisterAsBrowser [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pbRegister);
    put_RegisterAsBrowser [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL bRegister);
    get_RegisterAsDropTarget [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pbRegister);
    put_RegisterAsDropTarget [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL bRegister);
    get_TheaterMode [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *pbRegister);
    put_TheaterMode [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL bRegister);
    get_AddressBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *Value);
    put_AddressBar [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL Value);
    get_Resizable [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [retval][out] */ __RPC__out VARIANT_BOOL *Value);
    put_Resizable [function! [this [this!] value [int-ptr!] return: [integer!]]] ;/* [in] */ VARIANT_BOOL Value);
]