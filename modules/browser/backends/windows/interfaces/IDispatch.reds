Red/System [
	Title:	"IDispatch interface"
	Author: "Oldes"
	File: 	%IDispatch.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IDispatch: [00020400h 00000000h 000000C0h 46000000h]

IDispatch!: alias struct! [
	QueryInterface       [QueryInterface!]
	AddRef               [AddRef!]
	Release              [Release!]
    GetTypeInfoCount [integer!] 
    ;        __RPC__in IDispatch * This,
    ;        /* [out] */ __RPC__out UINT *pctinfo);
    GetTypeInfo [integer!]
    ;        __RPC__in IDispatch * This,
    ;        /* [in] */ UINT iTInfo,
    ;        /* [in] */ LCID lcid,
    ;        /* [out] */ __RPC__deref_out_opt ITypeInfo **ppTInfo);
    GetIDsOfNames [integer!]
    ;        __RPC__in IDispatch * This,
    ;        /* [in] */ __RPC__in REFIID riid,
    ;        /* [size_is][in] */ __RPC__in_ecount_full(cNames) LPOLESTR *rgszNames,
    ;        /* [range][in] */ __RPC__in_range(0,16384) UINT cNames,
    ;        /* [in] */ LCID lcid,
    ;        /* [size_is][out] */ __RPC__out_ecount_full(cNames) DISPID *rgDispId);
    Invoke [integer!]
    ;        IDispatch * This,
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
]