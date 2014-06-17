REBOL [
	Author:  "Oldes"
	Purpose: {Script for creating conversion matrix for TO action}
]

types-src: [
	{#"a"}
	{"foo"}
	{"foo  bar"} ;string with spaces
	{0}
	{123}
	{256}       ;integer bigger than 255
	{1.5}
	{-1}
	{-1.5}
	{1x2}
	{test-word}
	{test-lit-word}
	{test-set-word}
	{test-get-word}
	{/refinement}
	{test-path}
	{test-lit-path}
	{test-set-path}
	{test-get-path}
	{http://red-lang.org}
	{%/file/}
	{#FF00}     ;issue with only hexa chars
	{#00FF}     ;issue which starts with integer
	{#hello}    ;issue with not hexa chars
	{#{}}
	{#{616263}}
	{[]}        ;empty block
	{[1 2]}     ;block with 2 integers
	{[1 2 3]}   ;block with 3 integers
	{["a" "b"]} ;block with strings
	{1.1.1}    ;tuple! not yet supported in Red
	{test-paren-1}
	{test-paren-2}
	{<a>}
	{10:00}
	{16-Jun-2014/14:34:59+2:00}
	{foo@boo}
	{test-bitset}
	{#[true]}
	{#[none]}
]

specials: [
	{test-word}     	"word"
	{test-lit-word}	    "'lit-word"
	{test-set-word}	    "set-word:"
	{test-get-word}	    ":get-word"
	{test-path}		    "path/foo"
	{test-lit-path}     "'path/lit"
	{test-set-path}	    "path/set:"
	{test-get-path}	    ":path/get"
	{test-paren-1}      "()"
	{test-paren-2}      "(1 2)"
	{test-bitset}       "#[bitset! #{00}]"
]

types-trg: []
not-implemented: [tuple! tag! time! date! email! pair! url!]
not-supported: [
	"to-set-path!-refinement!"
	"to-get-path!-integer!"
	"to-set-path!-integer!"
	"to-get-path!-float!"
	"to-set-path!-float!"
	"to-get-path!-decimal!"
	"to-set-path!-decimal!"
	"to-get-path!-get-word!"
	"to-set-path!-get-word!"
	"to-get-path!-set-word!"
	"to-set-path!-set-word!"
	"to-get-path!-bitset!"
	{to get-path! [1 2]}
	{to get-path! [1 2 3]}
	{to get-path! test-paren-2}
	{to-issue!-logic!}
	{to-file!-logic!}
	{to-file!-lit-path!}
	{to-refinement!-logic!}
	{to-get-word!-logic!}
	{to-set-word!-logic!}
	{to-lit-word!-logic!}
	{to-word!-logic!}
		{to-integer!-issue!} ;maybe we could support that
	{to-get-path!-binary!}
	{to-set-path!-binary!}
	{to-lit-path!-binary!}
	{to-path!-binary!}
	{to-path!-file!}
	{to-decimal!-block!}
	{to-decimal!-paren!}
	{to-string!-logic!}

]
modified-results: [
	{to string! test-lit-word} {"'lit-word"}   ; there is a problem to get lit-word! in R3 -> test: first ['a] type? test == word!
	{to file! test-lit-word}   {%'lit-word}
	{to path! test-lit-word}   {{'lit-word}
	{to lit-word! #"a"}        {{'a}}
	{to lit-word! "foo"}       {{'foo}}
	{to lit-word! test-word}   {{'word}}
	{to lit-word! test-lit-word} {{'lit-word}}
	{to lit-word! test-set-word} {{'set-word}}
	{to lit-word! test-get-word} {{'get-word}}
	{to lit-word! /refinement} {{'refinement}}
	{to lit-word! #FF00}       {{'FF00}}
	{to lit-word! #hello}      {{'hello}}
	{to binary! 0}             {#{00000000}}   ; in R3: #{0000000000000000} 
	{to binary! 123}           {#{0000007B}}   ; in R3: #{000000000000007B} 
	{to binary! 256}           {#{00000100}}   ; in R3: #{0000000000000100}
	{to binary! -1}            {#{FFFFFFFF}}   ; in R3: #{FFFFFFFFFFFFFFFF}
	;these values are closed in another string as I compare molded values in the asserts
	{to block! "foo"}          {{["foo"]}}     ; in R3: "[foo]"
	{to block! "foo  bar"}     {{["foo  bar"]}}; in R3: "[foo bar]" ;two words
	{to block! #{}}            {{[#{}]}}       ; in R3: "[]"
	{to block! #{616263}}      {{[#{616263}]}} ; in R3: "[abc]"
	{to block! test-lit-word}  {{['lit-word]}} ; in R3: "[lit-word]"
	{to paren! "foo"}          {{("foo")}}     ; in R3: "(foo)"
	{to paren! "foo  bar"}     {{("foo  bar")}}; in R3: "(foo bar)" ;two words
	{to paren! test-lit-word}  {{('lit-word)}} ; in R3: "(lit-word)"
	{to paren! #{}}            {{(#{})}}       ; in R3: "()"
	{to paren! #{616263}}      {{(#{616263})}} ; in R3: "(abc)"
	{to integer! #{616263}}    {97}            ; in R3: 6382179
	{to path! %/file/}         {{/file/}}      ; in R3: "%/file/"   but this is not good resule anyway,
	                                           ;        it should be able recognize slashes and do correct path parts
	                                           ;        So f.ex.: length? to path! %foo/bar == would be 2 and not 1 as it's now.

]

foreach src types-src [
	type: type?/word load any [
			select specials src
			src
		]
	unless find types-trg type [
		append types-trg type
	]
]

mold2: func[data /local result][
	result: mold/flat data
	if any [block? data paren? data] [
		replace/all result "^/   " ""
		replace/all result "^/" ""
	]
	result
]

invalid: ""
tests:   ""
table:   ""
matrix:  ""
csv:     ""

foreach trg types-trg [
	append tests rejoin [{===start-group=== "to-} trg {"^/}]
	foreach src types-src [
		value: any [
			select specials src
			src
		]
		loaded-value: load value

		append matrix reform ["to" mold trg value " == "]
		append csv    rejoin ["to " mold trg #"^-" value #"^-"]

		either error? set/any 'result try [
			load mold to to datatype! trg loaded-value
			to to datatype! trg loaded-value
		][
			append matrix "error!^/"
			append csv    "error!^-^-^/"

			append invalid rejoin [
				"to" mold trg value lf
			]
		][
			type:   type?/word loaded-value
			name:   rejoin ["to-" trg "-" type]
			action: rejoin [{to } trg " " src]

			com: either any [
				find not-implemented trg
				find not-implemented type
				find not-supported name
				find not-supported action
			][";"][""]

			mresult: select modified-results action

			append matrix join mold result lf
			append csv    rejoin [mold result "^-"]
			if error? try [
				load mold to to datatype! trg loaded-value
			][
				append csv "not-back-loadable!"
			]
			append csv "^/"

			switch/default trg [
				url! 
				path!
				refinement!
				word!
				lit-word!
				set-word!
				get-word!
				set-path!
				get-path!
				lit-path!
				paren!
				bitset!
				block! [
					test: replace form trg "!" "?"
					append tests rejoin [
						com {	--test-- "} name {"^/}
						com {		--assert } test { } action lf
						com {		--assert } any [mresult mold2 mold result] { = mold } action lf  
					]
				]
			][
				append tests rejoin [
					com {	--test-- "to-} trg "-" type {"^/}
					com {		--assert } any [mresult mold2 result] { = } action lf
				]
			]
			append table rejoin [
				{<tr><td>to } trg {</td><td>} mold src {</td><td>} mold2 result {</td></tr>}
			]
		]
	]
	append csv "^/"
	append tests {===end-group===^/}
]

replace/all tests "decimal!" "float!"
;print "^/^/;=============== copy this into the unit test file =================^/"
;print tests

insert tests {
Red [
	Title:   "Red TO action test script"
	Author:  "Oldes"
	File: 	 to-action-test.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2013 Nenad Rakocevic & Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

test-word:      first [word]
test-lit-word:	first ['lit-word]
test-set-word:	first [set-word:]
test-get-word:	first [:get-word]
test-path:		first [path/foo]
test-lit-path:  first ['path/lit]
test-set-path:	first [path/set:]
test-get-path:	first [:path/get]
test-paren-1:   first [()]
test-paren-2:   first [(1 2)]
test-bitset:  make bitset! #{00}

~~~start-file~~~ "to"
}

append tests {

~~~end-file~~~
}

write %/r/to-action-test.red tests
write %/r/to-action-matrix.txt matrix

replace/all csv {"} {"""}
write %/r/to-action-matrix.csv csv
;print table