Red [
	Title:   "Red loading test script"
	Author:  "Nenad Rakocevic & Peter W A Wood"
	File: 	 %load-test.reds
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2012 Nenad Rakocevic & Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "load"

===start-group=== "Delimiter LOAD tests"

	--test-- "load-1"  --assert "" 		 = load {""}
	--test-- "load-2"  --assert "" 		 = load {{}}
	--test-- "load-3"  --assert "{" 	 = load {"^{"}
	--test-- "load-4"  --assert "}" 	 = load {"^}"}
	--test-- "load-5"  --assert "{}"	 = load {"^{^}"}
	--test-- "load-6"  --assert {^}^{} 	 = load {"^}^{"}
	--test-- "load-7"  --assert "^{^}^}" = load {"^{^}^}"}
	--test-- "load-8"  --assert ""		 = load {"^"}
	--test-- "load-9"  --assert ""		 = load "{}"
	--test-- "load-10" --assert "{"		 = load "{^{}"
	--test-- "load-11" --assert {"}		 = load {{"}}
	--test-- "load-12" --assert "^/" 	 = load "{^/}^/"
	--test-- "load-13" --assert "^/" 	 = load "{^/}"
	--test-- "load-14" --assert "{^/}"	 = load {{{^/}}}
	--test-- "load-15" --assert {{"x"}}	 = load {{{"x"}}}
	--test-- "load-16" --assert "{x}"	 = load {{{x}}}
	--test-- "load-17" --assert {"x"}	 = load {{"x"}}
	--test-- "load-18" --assert "x"		 = load {{x}}
	
===end-group===

===start-group=== "LOAD /part tests"
	src: "123abc789"

	--test-- "load-p1" --assert 123  = load/part src 3
	--test-- "load-p2" --assert 12   = load/part src 2
	--test-- "load-p3" --assert 1    = load/part src 1
	--test-- "load-p4" --assert []   = load/part src 0
	--test-- "load-p4" --assert 'abc = load/part skip src 3 3

===end-group===
 
===start-group=== "LOAD floats test"

	--test-- "load-30" --assert "123.0"	 = mold load "123.0"
	--test-- "load-31" --assert "1.123"  = mold load "1.123"
	--test-- "load-32" --assert "0.123"  = mold load ".123"
	--test-- "load-33" --assert "100.0"  = mold load "1E2"
	--test-- "load-34" --assert "1200.0" = mold load "1.2E3"
	--test-- "load-35" --assert "10.0"   = mold load ".1E2"
	--test-- "load-36" --assert "12.3"   = mold load ".123E2"

===end-group===

~~~end-file~~~

