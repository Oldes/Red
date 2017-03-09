Red/System [
	Title:	"IOleCommandTarget interface"
	Author: "Oldes"
	File: 	%IOleCommandTarget.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IOleCommandTarget: [B722BCCBh 101B4E68h AA00BCA2h 70474000h]

;Enables objects and their containers to dispatch commands to each other. For example, 
;an object's toolbars may contain buttons for commands such as Print, Print Preview, 
;Save, New, and Zoom.

;Normal in-place activation guidelines recommend that you remove or disable such buttons 
;because no efficient, standard mechanism has been available to dispatch them to the 
;container. Similarly, a container has heretofore had no efficient means to send commands 
;such as Print, Page Setup, and Properties to an in-place active object. Such simple 
;command routing could have been handled through existing OLE Automation standards and 
;the IDispatch interface, but the overhead with IDispatch is more than is required in the 
;case of document objects. The IOleCommandTarget interface provides a simpler means to 
;achieve the same ends.

;Available commands are defined by integer identifiers in a group. The group itself is identified 
;with a GUID. The interface allows a caller both to query for support of one or more commands 
;within a group and to issue a supported command to the object.

;-> https://msdn.microsoft.com/en-us/library/windows/desktop/ms683797(v=vs.85).aspx

IOleCommandTarget!: alias struct! [
	QueryInterface   [QueryInterface!]
	AddRef           [AddRef!]
	Release          [Release!]
	QueryStatus [
		function! [this [this!]
			pguidCmdGroup [int-ptr!] ;/* [unique][in] */ __RPC__in_opt const GUID *pguidCmdGroup,
			cCmds         [integer!] ;/* [in] */ ULONG cCmds,
			prgCmds       [int-ptr!] ;/* [out][in][size_is] */ __RPC__inout_ecount_full(cCmds) OLECMD prgCmds[  ],
			pCmdText      [int-ptr!] ;/* [unique][out][in] */ __RPC__inout_opt OLECMDTEXT *pCmdText);
			return:       [integer!] 
	]]
    Exec [
    	function! [this [this!]
    		pguidCmdGroup [int-ptr!]
    		nCmdID        [integer!]
    		nCmdexecopt   [integer!]
    		pvaIn         [int-ptr!]
    		pvaOut        [int-ptr!]
    		return: [integer!]
    ]]
]