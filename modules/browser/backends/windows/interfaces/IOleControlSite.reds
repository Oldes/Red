Red/System [
	Title:	"IOleControlSite interface"
	Author: "Oldes"
	File: 	%IOleControlSite.reds
	Tabs: 	4
	Rights: "Copyright (C) 2017 Oldes. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

IID_IOleControlSite: [B196B289h 101ABAB4h AA009CB6h 071D3400h]

;Provides the methods that enable a site object to manage each embedded control 
;within a container. A site object provides IOleControlSite as well as other 
;site interfaces such as IOleClientSite and IOleInPlaceSite. When a control 
;requires the services expressed through this interface, it will query one of 
;the other client site interfaces for IOleControlSite.

;-> https://msdn.microsoft.com/en-us/library/windows/desktop/ms688502(v=vs.85).aspx

;@@ TODO when needed