Red/System [
	Title:	"IHTMLDocument2 interface"
	Author: "Oldes"
	File: 	%IHTMLDocument2.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IHTMLDocument2: [332C4425h 11D026CBh C00083B4h 1901D94Fh]

IHTMLDocument2!: alias struct! [
	QueryInterface       [QueryInterface!]
	AddRef               [AddRef!]
	Release              [Release!]
    GetTypeInfoCount [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out] */ __RPC__out UINT *pctinfo);
    GetTypeInfo [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ UINT iTInfo,
    ;        /* [in] */ LCID lcid,
    ;        /* [out] */ __RPC__deref_out_opt ITypeInfo **ppTInfo);
    GetIDsOfNames [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in REFIID riid,
    ;        /* [size_is][in] */ __RPC__in_ecount_full(cNames) LPOLESTR *rgszNames,
    ;        /* [range][in] */ __RPC__in_range(0,16384) UINT cNames,
    ;        /* [in] */ LCID lcid,
    ;        /* [size_is][out] */ __RPC__out_ecount_full(cNames) DISPID *rgDispId);
    Invoke [integer!]
    ;        IHTMLDocument2 * This,
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
    get_Script [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IDispatch **p);
    get_all [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    get_body [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElement **p);
    get_activeElement [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElement **p);
    get_images [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    get_applets [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    get_links [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    get_forms [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    get_anchors [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    put_title [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR v);
    get_title [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_scripts [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    put_designMode [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR v);
    get_designMode [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_selection [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLSelectionObject **p);
    get_readyState [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_frames [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLFramesCollection2 **p);
    get_embeds [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    get_plugins [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElementCollection **p);
    put_alinkColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_alinkColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_bgColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_bgColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_fgColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_fgColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_linkColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_linkColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_vlinkColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_vlinkColor [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    get_referrer [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_location [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLLocation **p);
    get_lastModified [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    put_URL [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR v);
    get_URL [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    put_domain [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR v);
    get_domain [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    put_cookie [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR v);
    get_cookie [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    put_expando [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT_BOOL v);
    get_expando [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT_BOOL *p);
    put_charset [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR v);
    get_charset [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    put_defaultCharset [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR v);
    get_defaultCharset [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_mimeType [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_fileSize [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_fileCreatedDate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_fileModifiedDate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_fileUpdatedDate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_security [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_protocol [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    get_nameProp [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *p);
    write [function! [this [this!] psarray [int-ptr!] return: [integer!]]]
    writeln [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in SAFEARRAY * psarray);
    open [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in][defaultvalue] */ __RPC__in BSTR url,
    ;        /* [in][optional] */ VARIANT name,
    ;        /* [in][optional] */ VARIANT features,
    ;        /* [in][optional] */ VARIANT replace,
    ;        /* [out][retval] */ __RPC__deref_out_opt IDispatch **pomWindowResult);
    close [function! [this [this!] return: [integer!]]]  
    clear [function! [this [this!] return: [integer!]]]   
    queryCommandSupported [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [out][retval] */ __RPC__out VARIANT_BOOL *pfRet);
    queryCommandEnabled [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [out][retval] */ __RPC__out VARIANT_BOOL *pfRet);
    queryCommandState [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [out][retval] */ __RPC__out VARIANT_BOOL *pfRet);
    queryCommandIndeterm [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [out][retval] */ __RPC__out VARIANT_BOOL *pfRet);
    queryCommandText [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *pcmdText);
    queryCommandValue [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [out][retval] */ __RPC__out VARIANT *pcmdValue);
    execCommand [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [in][defaultvalue] */ VARIANT_BOOL showUI,
    ;        /* [in][optional] */ VARIANT value,
    ;        /* [out][retval] */ __RPC__out VARIANT_BOOL *pfRet);
    execCommandShowHelp [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR cmdID,
    ;        /* [out][retval] */ __RPC__out VARIANT_BOOL *pfRet);
    createElement [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ __RPC__in BSTR eTag,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElement **newElem);
    put_onhelp [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onhelp [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onclick [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onclick [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_ondblclick [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_ondblclick [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onkeyup [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onkeyup [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onkeydown [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onkeydown [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onkeypress [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onkeypress [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onmouseup [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onmouseup [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onmousedown [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onmousedown [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onmousemove [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onmousemove [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onmouseout [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onmouseout [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onmouseover [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onmouseover [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onreadystatechange [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onreadystatechange [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onafterupdate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onafterupdate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onrowexit [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onrowexit [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onrowenter [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onrowenter [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_ondragstart [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_ondragstart [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onselectstart [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onselectstart [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    elementFromPoint [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ long x,
    ;        /* [in] */ long y,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLElement **elementHit);
    get_parentWindow [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLWindow2 **p);
    get_styleSheets [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLStyleSheetsCollection **p);
    put_onbeforeupdate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onbeforeupdate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    put_onerrorupdate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in] */ VARIANT v);
    get_onerrorupdate [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__out VARIANT *p);
    toString [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [out][retval] */ __RPC__deref_out_opt BSTR *String);
    createStyleSheet [integer!]
    ;        __RPC__in IHTMLDocument2 * This,
    ;        /* [in][defaultvalue] */ __RPC__in BSTR bstrHref,
    ;        /* [in][defaultvalue] */ long lIndex,
    ;        /* [out][retval] */ __RPC__deref_out_opt IHTMLStyleSheet **ppnewStyleSheet);
]