
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
===start-group=== "to-char!"
	--test-- "to-char!-char!"
		--assert #"a" = to char! #"a"
	--test-- "to-char!-string!"
		--assert #"f" = to char! "foo"
	--test-- "to-char!-string!"
		--assert #"f" = to char! "foo  bar"
	--test-- "to-char!-integer!"
		--assert #"^@" = to char! 0
	--test-- "to-char!-integer!"
		--assert #"{" = to char! 123
	--test-- "to-char!-integer!"
		--assert #"Ā" = to char! 256
	--test-- "to-char!-float!"
		--assert #"^A" = to char! 1.5
	--test-- "to-char!-binary!"
		--assert #"a" = to char! #{616263}
===end-group===
===start-group=== "to-string!"
	--test-- "to-string!-char!"
		--assert "a" = to string! #"a"
	--test-- "to-string!-string!"
		--assert "foo" = to string! "foo"
	--test-- "to-string!-string!"
		--assert "foo  bar" = to string! "foo  bar"
	--test-- "to-string!-integer!"
		--assert "0" = to string! 0
	--test-- "to-string!-integer!"
		--assert "123" = to string! 123
	--test-- "to-string!-integer!"
		--assert "256" = to string! 256
	--test-- "to-string!-float!"
		--assert "1.5" = to string! 1.5
	--test-- "to-string!-integer!"
		--assert "-1" = to string! -1
	--test-- "to-string!-float!"
		--assert "-1.5" = to string! -1.5
;	--test-- "to-string!-pair!"
;		--assert "1x2" = to string! 1x2
	--test-- "to-string!-word!"
		--assert "word" = to string! test-word
	--test-- "to-string!-word!"
		--assert "'lit-word" = to string! test-lit-word
	--test-- "to-string!-set-word!"
		--assert "set-word:" = to string! test-set-word
	--test-- "to-string!-get-word!"
		--assert ":get-word" = to string! test-get-word
	--test-- "to-string!-refinement!"
		--assert "/refinement" = to string! /refinement
	--test-- "to-string!-path!"
		--assert "path/foo" = to string! test-path
	--test-- "to-string!-lit-path!"
		--assert "'path/lit" = to string! test-lit-path
	--test-- "to-string!-set-path!"
		--assert "path/set:" = to string! test-set-path
	--test-- "to-string!-get-path!"
		--assert ":path/get" = to string! test-get-path
;	--test-- "to-string!-url!"
;		--assert "http://red-lang.org" = to string! http://red-lang.org
	--test-- "to-string!-file!"
		--assert "/file/" = to string! %/file/
	--test-- "to-string!-issue!"
		--assert "#FF00" = to string! #FF00
	--test-- "to-string!-issue!"
		--assert "#00FF" = to string! #00FF
	--test-- "to-string!-issue!"
		--assert "#hello" = to string! #hello
	--test-- "to-string!-binary!"
		--assert "" = to string! #{}
	--test-- "to-string!-binary!"
		--assert "abc" = to string! #{616263}
	--test-- "to-string!-block!"
		--assert "" = to string! []
	--test-- "to-string!-block!"
		--assert "12" = to string! [1 2]
	--test-- "to-string!-block!"
		--assert "123" = to string! [1 2 3]
	--test-- "to-string!-block!"
		--assert "ab" = to string! ["a" "b"]
;	--test-- "to-string!-tuple!"
;		--assert "1.1.1" = to string! 1.1.1
	--test-- "to-string!-paren!"
		--assert "" = to string! test-paren-1
	--test-- "to-string!-paren!"
		--assert "12" = to string! test-paren-2
;	--test-- "to-string!-tag!"
;		--assert "a" = to string! <a>
;	--test-- "to-string!-time!"
;		--assert "10:00" = to string! 10:00
;	--test-- "to-string!-date!"
;		--assert "16-Jun-2014/14:34:59+2:00" = to string! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-string!-email!"
;		--assert "foo@boo" = to string! foo@boo
	--test-- "to-string!-bitset!"
		--assert "make bitset! #{00}" = to string! test-bitset
;	--test-- "to-string!-logic!"
;		--assert "true" = to string! #[true]
===end-group===
===start-group=== "to-integer!"
	--test-- "to-integer!-char!"
		--assert 97 = to integer! #"a"
	--test-- "to-integer!-integer!"
		--assert 0 = to integer! 0
	--test-- "to-integer!-integer!"
		--assert 123 = to integer! 123
	--test-- "to-integer!-integer!"
		--assert 256 = to integer! 256
	--test-- "to-integer!-float!"
		--assert 1 = to integer! 1.5
	--test-- "to-integer!-integer!"
		--assert -1 = to integer! -1
	--test-- "to-integer!-float!"
		--assert -1 = to integer! -1.5
;	--test-- "to-integer!-issue!"
;		--assert 65280 = to integer! #FF00
;	--test-- "to-integer!-issue!"
;		--assert 255 = to integer! #00FF
	--test-- "to-integer!-binary!"
		--assert 0 = to integer! #{}
	--test-- "to-integer!-binary!"
		--assert 97 = to integer! #{616263}
;	--test-- "to-integer!-time!"
;		--assert 36000 = to integer! 10:00
===end-group===
===start-group=== "to-float!"
	--test-- "to-float!-char!"
		--assert 97.0 = to float! #"a"
	--test-- "to-float!-integer!"
		--assert 0.0 = to float! 0
	--test-- "to-float!-integer!"
		--assert 123.0 = to float! 123
	--test-- "to-float!-integer!"
		--assert 256.0 = to float! 256
	--test-- "to-float!-float!"
		--assert 1.5 = to float! 1.5
	--test-- "to-float!-integer!"
		--assert -1.0 = to float! -1
	--test-- "to-float!-float!"
		--assert -1.5 = to float! -1.5
	--test-- "to-float!-binary!"
		--assert 0.0 = to float! #{}
	--test-- "to-float!-binary!"
		--assert 3.1532154e-317 = to float! #{616263}
;	--test-- "to-float!-block!"
;		--assert 100.0 = to float! [1 2]
;	--test-- "to-float!-paren!"
;		--assert 100.0 = to float! test-paren-2
;	--test-- "to-float!-time!"
;		--assert 36000.0 = to float! 10:00
	--test-- "to-float!-logic!"
		--assert 1.0 = to float! #[true]
===end-group===
===start-group=== "to-pair!"
;	--test-- "to-pair!-integer!"
;		--assert 0x0 = to pair! 0
;	--test-- "to-pair!-integer!"
;		--assert 123x123 = to pair! 123
;	--test-- "to-pair!-integer!"
;		--assert 256x256 = to pair! 256
;	--test-- "to-pair!-float!"
;		--assert 1.5x1.5 = to pair! 1.5
;	--test-- "to-pair!-integer!"
;		--assert -1x-1 = to pair! -1
;	--test-- "to-pair!-float!"
;		--assert -1.5x-1.5 = to pair! -1.5
;	--test-- "to-pair!-pair!"
;		--assert 1x2 = to pair! 1x2
;	--test-- "to-pair!-block!"
;		--assert 1x2 = to pair! [1 2]
===end-group===
===start-group=== "to-word!"
	--test-- "to-word!-char!"
		--assert word? to word! #"a"
		--assert "a" = mold to word! #"a"
	--test-- "to-word!-string!"
		--assert word? to word! "foo"
		--assert "foo" = mold to word! "foo"
	--test-- "to-word!-word!"
		--assert word? to word! test-word
		--assert "word" = mold to word! test-word
	--test-- "to-word!-word!"
		--assert word? to word! test-lit-word
		--assert "lit-word" = mold to word! test-lit-word
	--test-- "to-word!-set-word!"
		--assert word? to word! test-set-word
		--assert "set-word" = mold to word! test-set-word
	--test-- "to-word!-get-word!"
		--assert word? to word! test-get-word
		--assert "get-word" = mold to word! test-get-word
	--test-- "to-word!-refinement!"
		--assert word? to word! /refinement
		--assert "refinement" = mold to word! /refinement
	--test-- "to-word!-issue!"
		--assert word? to word! #FF00
		--assert "FF00" = mold to word! #FF00
	--test-- "to-word!-issue!"
		--assert word? to word! #hello
		--assert "hello" = mold to word! #hello
;	--test-- "to-word!-logic!"
;		--assert word? to word! #[true]
;		--assert "true" = mold to word! #[true]
===end-group===
===start-group=== "to-lit-word!"
	--test-- "to-lit-word!-char!"
		--assert lit-word? to lit-word! #"a"
		--assert {'a} = mold to lit-word! #"a"
	--test-- "to-lit-word!-string!"
		--assert lit-word? to lit-word! "foo"
		--assert {'foo} = mold to lit-word! "foo"
	--test-- "to-lit-word!-word!"
		--assert lit-word? to lit-word! test-word
		--assert {'word} = mold to lit-word! test-word
	--test-- "to-lit-word!-word!"
		--assert lit-word? to lit-word! test-lit-word
		--assert {'lit-word} = mold to lit-word! test-lit-word
	--test-- "to-lit-word!-set-word!"
		--assert lit-word? to lit-word! test-set-word
		--assert {'set-word} = mold to lit-word! test-set-word
	--test-- "to-lit-word!-get-word!"
		--assert lit-word? to lit-word! test-get-word
		--assert {'get-word} = mold to lit-word! test-get-word
	--test-- "to-lit-word!-refinement!"
		--assert lit-word? to lit-word! /refinement
		--assert {'refinement} = mold to lit-word! /refinement
	--test-- "to-lit-word!-issue!"
		--assert lit-word? to lit-word! #FF00
		--assert {'FF00} = mold to lit-word! #FF00
	--test-- "to-lit-word!-issue!"
		--assert lit-word? to lit-word! #hello
		--assert {'hello} = mold to lit-word! #hello
;	--test-- "to-lit-word!-logic!"
;		--assert lit-word? to lit-word! #[true]
;		--assert "true" = mold to lit-word! #[true]
===end-group===
===start-group=== "to-set-word!"
	--test-- "to-set-word!-char!"
		--assert set-word? to set-word! #"a"
		--assert "a:" = mold to set-word! #"a"
	--test-- "to-set-word!-string!"
		--assert set-word? to set-word! "foo"
		--assert "foo:" = mold to set-word! "foo"
	--test-- "to-set-word!-word!"
		--assert set-word? to set-word! test-word
		--assert "word:" = mold to set-word! test-word
	--test-- "to-set-word!-word!"
		--assert set-word? to set-word! test-lit-word
		--assert "lit-word:" = mold to set-word! test-lit-word
	--test-- "to-set-word!-set-word!"
		--assert set-word? to set-word! test-set-word
		--assert "set-word:" = mold to set-word! test-set-word
	--test-- "to-set-word!-get-word!"
		--assert set-word? to set-word! test-get-word
		--assert "get-word:" = mold to set-word! test-get-word
	--test-- "to-set-word!-refinement!"
		--assert set-word? to set-word! /refinement
		--assert "refinement:" = mold to set-word! /refinement
	--test-- "to-set-word!-issue!"
		--assert set-word? to set-word! #FF00
		--assert "FF00:" = mold to set-word! #FF00
	--test-- "to-set-word!-issue!"
		--assert set-word? to set-word! #hello
		--assert "hello:" = mold to set-word! #hello
;	--test-- "to-set-word!-logic!"
;		--assert set-word? to set-word! #[true]
;		--assert "true:" = mold to set-word! #[true]
===end-group===
===start-group=== "to-get-word!"
	--test-- "to-get-word!-char!"
		--assert get-word? to get-word! #"a"
		--assert ":a" = mold to get-word! #"a"
	--test-- "to-get-word!-string!"
		--assert get-word? to get-word! "foo"
		--assert ":foo" = mold to get-word! "foo"
	--test-- "to-get-word!-word!"
		--assert get-word? to get-word! test-word
		--assert ":word" = mold to get-word! test-word
	--test-- "to-get-word!-word!"
		--assert get-word? to get-word! test-lit-word
		--assert ":lit-word" = mold to get-word! test-lit-word
	--test-- "to-get-word!-set-word!"
		--assert get-word? to get-word! test-set-word
		--assert ":set-word" = mold to get-word! test-set-word
	--test-- "to-get-word!-get-word!"
		--assert get-word? to get-word! test-get-word
		--assert ":get-word" = mold to get-word! test-get-word
	--test-- "to-get-word!-refinement!"
		--assert get-word? to get-word! /refinement
		--assert ":refinement" = mold to get-word! /refinement
	--test-- "to-get-word!-issue!"
		--assert get-word? to get-word! #FF00
		--assert ":FF00" = mold to get-word! #FF00
	--test-- "to-get-word!-issue!"
		--assert get-word? to get-word! #hello
		--assert ":hello" = mold to get-word! #hello
;	--test-- "to-get-word!-logic!"
;		--assert get-word? to get-word! #[true]
;		--assert ":true" = mold to get-word! #[true]
===end-group===
===start-group=== "to-refinement!"
	--test-- "to-refinement!-char!"
		--assert refinement? to refinement! #"a"
		--assert "/a" = mold to refinement! #"a"
	--test-- "to-refinement!-string!"
		--assert refinement? to refinement! "foo"
		--assert "/foo" = mold to refinement! "foo"
	--test-- "to-refinement!-word!"
		--assert refinement? to refinement! test-word
		--assert "/word" = mold to refinement! test-word
	--test-- "to-refinement!-word!"
		--assert refinement? to refinement! test-lit-word
		--assert "/lit-word" = mold to refinement! test-lit-word
	--test-- "to-refinement!-set-word!"
		--assert refinement? to refinement! test-set-word
		--assert "/set-word" = mold to refinement! test-set-word
	--test-- "to-refinement!-get-word!"
		--assert refinement? to refinement! test-get-word
		--assert "/get-word" = mold to refinement! test-get-word
	--test-- "to-refinement!-refinement!"
		--assert refinement? to refinement! /refinement
		--assert "/refinement" = mold to refinement! /refinement
	--test-- "to-refinement!-issue!"
		--assert refinement? to refinement! #FF00
		--assert "/FF00" = mold to refinement! #FF00
	--test-- "to-refinement!-issue!"
		--assert refinement? to refinement! #00FF
		--assert "/00FF" = mold to refinement! #00FF
	--test-- "to-refinement!-issue!"
		--assert refinement? to refinement! #hello
		--assert "/hello" = mold to refinement! #hello
;	--test-- "to-refinement!-logic!"
;		--assert refinement? to refinement! #[true]
;		--assert "/true" = mold to refinement! #[true]
===end-group===
===start-group=== "to-path!"
	--test-- "to-path!-char!"
		--assert path? to path! #"a"
		--assert {#"a"} = mold to path! #"a"
	--test-- "to-path!-string!"
		--assert path? to path! "foo"
		--assert "foo" = mold to path! "foo"
	--test-- "to-path!-string!"
		--assert path? to path! "foo  bar"
		--assert "foo/bar" = mold to path! "foo  bar"
	--test-- "to-path!-integer!"
		--assert path? to path! 0
		--assert "0" = mold to path! 0
	--test-- "to-path!-integer!"
		--assert path? to path! 123
		--assert "123" = mold to path! 123
	--test-- "to-path!-integer!"
		--assert path? to path! 256
		--assert "256" = mold to path! 256
	--test-- "to-path!-float!"
		--assert path? to path! 1.5
		--assert "1.5" = mold to path! 1.5
	--test-- "to-path!-integer!"
		--assert path? to path! -1
		--assert "-1" = mold to path! -1
	--test-- "to-path!-float!"
		--assert path? to path! -1.5
		--assert "-1.5" = mold to path! -1.5
;	--test-- "to-path!-pair!"
;		--assert path? to path! 1x2
;		--assert "1x2" = mold to path! 1x2
	--test-- "to-path!-word!"
		--assert path? to path! test-word
		--assert "word" = mold to path! test-word
	--test-- "to-path!-word!"
		--assert path? to path! test-lit-word
		--assert "'lit-word" = mold to path! test-lit-word
	--test-- "to-path!-set-word!"
		--assert path? to path! test-set-word
		--assert "set-word:" = mold to path! test-set-word
	--test-- "to-path!-get-word!"
		--assert path? to path! test-get-word
		--assert ":get-word" = mold to path! test-get-word
	--test-- "to-path!-refinement!"
		--assert path? to path! /refinement
		--assert "/refinement" = mold to path! /refinement
	--test-- "to-path!-path!"
		--assert path? to path! test-path
		--assert "path/foo" = mold to path! test-path
	--test-- "to-path!-lit-path!"
		--assert path? to path! test-lit-path
		--assert "path/lit" = mold to path! test-lit-path
	--test-- "to-path!-set-path!"
		--assert path? to path! test-set-path
		--assert "path/set" = mold to path! test-set-path
	--test-- "to-path!-get-path!"
		--assert path? to path! test-get-path
		--assert "path/get" = mold to path! test-get-path
;	--test-- "to-path!-url!"
;		--assert path? to path! http://red-lang.org
;		--assert "http://red-lang.org" = mold to path! http://red-lang.org
;	--test-- "to-path!-file!"
;		--assert path? to path! %/file/
;		--assert {/file/} = mold to path! %/file/
	--test-- "to-path!-issue!"
		--assert path? to path! #FF00
		--assert "#FF00" = mold to path! #FF00
	--test-- "to-path!-issue!"
		--assert path? to path! #00FF
		--assert "#00FF" = mold to path! #00FF
	--test-- "to-path!-issue!"
		--assert path? to path! #hello
		--assert "#hello" = mold to path! #hello
;	--test-- "to-path!-binary!"
;		--assert path? to path! #{616263}
;		--assert "abc" = mold to path! #{616263}
	--test-- "to-path!-block!"
		--assert path? to path! [1 2 3]
		--assert "1/2/3" = mold to path! [1 2 3]
	--test-- "to-path!-block!"
		--assert path? to path! ["a" "b"]
		--assert {"a"/"b"} = mold to path! ["a" "b"]
;	--test-- "to-path!-tuple!"
;		--assert path? to path! 1.1.1
;		--assert "1.1.1" = mold to path! 1.1.1
;	--test-- "to-path!-tag!"
;		--assert path? to path! <a>
;		--assert "<a>" = mold to path! <a>
;	--test-- "to-path!-time!"
;		--assert path? to path! 10:00
;		--assert "10:00" = mold to path! 10:00
;	--test-- "to-path!-date!"
;		--assert path? to path! 16-Jun-2014/14:34:59+2:00
;		--assert "16-Jun-2014/14:34:59+2:00" = mold to path! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-path!-email!"
;		--assert path? to path! foo@boo
;		--assert "foo@boo" = mold to path! foo@boo
	--test-- "to-path!-bitset!"
		--assert path? to path! test-bitset
		--assert "make bitset! #{00}" = mold to path! test-bitset
	--test-- "to-path!-logic!"
		--assert path? to path! #[true]
		--assert "true" = mold to path! #[true]
	--test-- "to-path!-none!"
		--assert path? to path! #[none]
		--assert "none" = mold to path! #[none]
===end-group===
===start-group=== "to-lit-path!"
	--test-- "to-lit-path!-string!"
		--assert lit-path? to lit-path! "foo"
		--assert "'foo" = mold to lit-path! "foo"
	--test-- "to-lit-path!-string!"
		--assert lit-path? to lit-path! "foo  bar"
		--assert "'foo/bar" = mold to lit-path! "foo  bar"
	--test-- "to-lit-path!-word!"
		--assert lit-path? to lit-path! test-word
		--assert "'word" = mold to lit-path! test-word
	--test-- "to-lit-path!-word!"
		--assert lit-path? to lit-path! test-lit-word
		--assert "'lit-word" = mold to lit-path! test-lit-word
	--test-- "to-lit-path!-path!"
		--assert lit-path? to lit-path! test-path
		--assert "'path/foo" = mold to lit-path! test-path
	--test-- "to-lit-path!-lit-path!"
		--assert lit-path? to lit-path! test-lit-path
		--assert "'path/lit" = mold to lit-path! test-lit-path
	--test-- "to-lit-path!-set-path!"
		--assert lit-path? to lit-path! test-set-path
		--assert "'path/set" = mold to lit-path! test-set-path
	--test-- "to-lit-path!-get-path!"
		--assert lit-path? to lit-path! test-get-path
		--assert "'path/get" = mold to lit-path! test-get-path
;	--test-- "to-lit-path!-binary!"
;		--assert lit-path? to lit-path! #{616263}
;		--assert "'abc" = mold to lit-path! #{616263}
;	--test-- "to-lit-path!-email!"
;		--assert lit-path? to lit-path! foo@boo
;		--assert "'foo@boo" = mold to lit-path! foo@boo
	--test-- "to-lit-path!-bitset!"
		--assert lit-path? to lit-path! test-bitset
		--assert "'make bitset! #{00}" = mold to lit-path! test-bitset
	--test-- "to-lit-path!-logic!"
		--assert lit-path? to lit-path! #[true]
		--assert "'true" = mold to lit-path! #[true]
	--test-- "to-lit-path!-none!"
		--assert lit-path? to lit-path! #[none]
		--assert "'none" = mold to lit-path! #[none]
===end-group===
===start-group=== "to-set-path!"
	--test-- "to-set-path!-string!"
		--assert set-path? to set-path! "foo"
		--assert "foo:" = mold to set-path! "foo"
	--test-- "to-set-path!-string!"
		--assert set-path? to set-path! "foo  bar"
		--assert "foo/bar:" = mold to set-path! "foo  bar"
	--test-- "to-set-path!-word!"
		--assert set-path? to set-path! test-word
		--assert "word:" = mold to set-path! test-word
	--test-- "to-set-path!-word!"
		--assert set-path? to set-path! test-lit-word
		--assert "lit-word:" = mold to set-path! test-lit-word
;	--test-- "to-set-path!-set-word!"
;		--assert set-path? to set-path! test-set-word
;		--assert "set-word::" = mold to set-path! test-set-word
;	--test-- "to-set-path!-refinement!"
;		--assert set-path? to set-path! /refinement
;		--assert "/refinement:" = mold to set-path! /refinement
	--test-- "to-set-path!-path!"
		--assert set-path? to set-path! test-path
		--assert "path/foo:" = mold to set-path! test-path
	--test-- "to-set-path!-lit-path!"
		--assert set-path? to set-path! test-lit-path
		--assert "path/lit:" = mold to set-path! test-lit-path
	--test-- "to-set-path!-set-path!"
		--assert set-path? to set-path! test-set-path
		--assert "path/set:" = mold to set-path! test-set-path
	--test-- "to-set-path!-get-path!"
		--assert set-path? to set-path! test-get-path
		--assert "path/get:" = mold to set-path! test-get-path
;	--test-- "to-set-path!-url!"
;		--assert set-path? to set-path! http://red-lang.org
;		--assert "http://red-lang.org:" = mold to set-path! http://red-lang.org
;	--test-- "to-set-path!-binary!"
;		--assert set-path? to set-path! #{616263}
;		--assert "abc:" = mold to set-path! #{616263}
	--test-- "to-set-path!-logic!"
		--assert set-path? to set-path! #[true]
		--assert "true:" = mold to set-path! #[true]
	--test-- "to-set-path!-none!"
		--assert set-path? to set-path! #[none]
		--assert "none:" = mold to set-path! #[none]
===end-group===
===start-group=== "to-get-path!"
	--test-- "to-get-path!-string!"
		--assert get-path? to get-path! "foo"
		--assert ":foo" = mold to get-path! "foo"
	--test-- "to-get-path!-string!"
		--assert get-path? to get-path! "foo  bar"
		--assert ":foo/bar" = mold to get-path! "foo  bar"
;	--test-- "to-get-path!-integer!"
;		--assert get-path? to get-path! 0
;		--assert ":0" = mold to get-path! 0
;	--test-- "to-get-path!-integer!"
;		--assert get-path? to get-path! 123
;		--assert ":123" = mold to get-path! 123
;	--test-- "to-get-path!-integer!"
;		--assert get-path? to get-path! 256
;		--assert ":256" = mold to get-path! 256
;	--test-- "to-get-path!-float!"
;		--assert get-path? to get-path! 1.5
;		--assert ":1.5" = mold to get-path! 1.5
;	--test-- "to-get-path!-integer!"
;		--assert get-path? to get-path! -1
;		--assert ":-1" = mold to get-path! -1
;	--test-- "to-get-path!-float!"
;		--assert get-path? to get-path! -1.5
;		--assert ":-1.5" = mold to get-path! -1.5
	--test-- "to-get-path!-word!"
		--assert get-path? to get-path! test-word
		--assert ":word" = mold to get-path! test-word
	--test-- "to-get-path!-word!"
		--assert get-path? to get-path! test-lit-word
		--assert ":lit-word" = mold to get-path! test-lit-word
;	--test-- "to-get-path!-get-word!"
;		--assert get-path? to get-path! test-get-word
;		--assert "::get-word" = mold to get-path! test-get-word
	--test-- "to-get-path!-path!"
		--assert get-path? to get-path! test-path
		--assert ":path/foo" = mold to get-path! test-path
	--test-- "to-get-path!-lit-path!"
		--assert get-path? to get-path! test-lit-path
		--assert ":path/lit" = mold to get-path! test-lit-path
	--test-- "to-get-path!-set-path!"
		--assert get-path? to get-path! test-set-path
		--assert ":path/set" = mold to get-path! test-set-path
	--test-- "to-get-path!-get-path!"
		--assert get-path? to get-path! test-get-path
		--assert ":path/get" = mold to get-path! test-get-path
;	--test-- "to-get-path!-binary!"
;		--assert get-path? to get-path! #{616263}
;		--assert ":abc" = mold to get-path! #{616263}
;	--test-- "to-get-path!-block!"
;		--assert get-path? to get-path! [1 2]
;		--assert ":1/2" = mold to get-path! [1 2]
;	--test-- "to-get-path!-block!"
;		--assert get-path? to get-path! [1 2 3]
;		--assert ":1/2/3" = mold to get-path! [1 2 3]
;	--test-- "to-get-path!-paren!"
;		--assert get-path? to get-path! test-paren-2
;		--assert ":1/2" = mold to get-path! test-paren-2
;	--test-- "to-get-path!-time!"
;		--assert get-path? to get-path! 10:00
;		--assert ":10:00" = mold to get-path! 10:00
;	--test-- "to-get-path!-email!"
;		--assert get-path? to get-path! foo@boo
;		--assert ":foo@boo" = mold to get-path! foo@boo
;	--test-- "to-get-path!-bitset!"
;		--assert get-path? to get-path! test-bitset
;		--assert ":make bitset! #{00}" = mold to get-path! test-bitset
	--test-- "to-get-path!-logic!"
		--assert get-path? to get-path! #[true]
		--assert ":true" = mold to get-path! #[true]
	--test-- "to-get-path!-none!"
		--assert get-path? to get-path! #[none]
		--assert ":none" = mold to get-path! #[none]
===end-group===
===start-group=== "to-url!"
;	--test-- "to-url!-char!"
;		--assert url? to url! #"a"
;		--assert "a" = mold to url! #"a"
;	--test-- "to-url!-string!"
;		--assert url? to url! "foo"
;		--assert "foo" = mold to url! "foo"
;	--test-- "to-url!-integer!"
;		--assert url? to url! 0
;		--assert "0" = mold to url! 0
;	--test-- "to-url!-integer!"
;		--assert url? to url! 123
;		--assert "123" = mold to url! 123
;	--test-- "to-url!-integer!"
;		--assert url? to url! 256
;		--assert "256" = mold to url! 256
;	--test-- "to-url!-float!"
;		--assert url? to url! 1.5
;		--assert "1.5" = mold to url! 1.5
;	--test-- "to-url!-integer!"
;		--assert url? to url! -1
;		--assert "-1" = mold to url! -1
;	--test-- "to-url!-float!"
;		--assert url? to url! -1.5
;		--assert "-1.5" = mold to url! -1.5
;	--test-- "to-url!-pair!"
;		--assert url? to url! 1x2
;		--assert "1x2" = mold to url! 1x2
;	--test-- "to-url!-word!"
;		--assert url? to url! test-word
;		--assert "word" = mold to url! test-word
;	--test-- "to-url!-word!"
;		--assert url? to url! test-lit-word
;		--assert "lit-word" = mold to url! test-lit-word
;	--test-- "to-url!-set-word!"
;		--assert url? to url! test-set-word
;		--assert "set-word:" = mold to url! test-set-word
;	--test-- "to-url!-get-word!"
;		--assert url? to url! test-get-word
;		--assert ":get-word" = mold to url! test-get-word
;	--test-- "to-url!-refinement!"
;		--assert url? to url! /refinement
;		--assert "/refinement" = mold to url! /refinement
;	--test-- "to-url!-path!"
;		--assert url? to url! test-path
;		--assert "path/foo" = mold to url! test-path
;	--test-- "to-url!-lit-path!"
;		--assert url? to url! test-lit-path
;		--assert "'path/lit" = mold to url! test-lit-path
;	--test-- "to-url!-set-path!"
;		--assert url? to url! test-set-path
;		--assert "path/set:" = mold to url! test-set-path
;	--test-- "to-url!-get-path!"
;		--assert url? to url! test-get-path
;		--assert ":path/get" = mold to url! test-get-path
;	--test-- "to-url!-url!"
;		--assert url? to url! http://red-lang.org
;		--assert "http://red-lang.org" = mold to url! http://red-lang.org
;	--test-- "to-url!-file!"
;		--assert url? to url! %/file/
;		--assert "/file/" = mold to url! %/file/
;	--test-- "to-url!-issue!"
;		--assert url? to url! #FF00
;		--assert "#FF00" = mold to url! #FF00
;	--test-- "to-url!-issue!"
;		--assert url? to url! #00FF
;		--assert "#00FF" = mold to url! #00FF
;	--test-- "to-url!-issue!"
;		--assert url? to url! #hello
;		--assert "#hello" = mold to url! #hello
;	--test-- "to-url!-binary!"
;		--assert url? to url! #{}
;		--assert "" = mold to url! #{}
;	--test-- "to-url!-binary!"
;		--assert url? to url! #{616263}
;		--assert "abc" = mold to url! #{616263}
;	--test-- "to-url!-block!"
;		--assert url? to url! []
;		--assert "" = mold to url! []
;	--test-- "to-url!-block!"
;		--assert url? to url! [1 2]
;		--assert "12" = mold to url! [1 2]
;	--test-- "to-url!-block!"
;		--assert url? to url! [1 2 3]
;		--assert "123" = mold to url! [1 2 3]
;	--test-- "to-url!-block!"
;		--assert url? to url! ["a" "b"]
;		--assert "ab" = mold to url! ["a" "b"]
;	--test-- "to-url!-tuple!"
;		--assert url? to url! 1.1.1
;		--assert "1.1.1" = mold to url! 1.1.1
;	--test-- "to-url!-paren!"
;		--assert url? to url! test-paren-1
;		--assert "" = mold to url! test-paren-1
;	--test-- "to-url!-paren!"
;		--assert url? to url! test-paren-2
;		--assert "12" = mold to url! test-paren-2
;	--test-- "to-url!-tag!"
;		--assert url? to url! <a>
;		--assert "a" = mold to url! <a>
;	--test-- "to-url!-time!"
;		--assert url? to url! 10:00
;		--assert "10:00" = mold to url! 10:00
;	--test-- "to-url!-date!"
;		--assert url? to url! 16-Jun-2014/14:34:59+2:00
;		--assert "16-Jun-2014/14:34:59+2:00" = mold to url! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-url!-email!"
;		--assert url? to url! foo@boo
;		--assert "foo@boo" = mold to url! foo@boo
;	--test-- "to-url!-logic!"
;		--assert url? to url! #[true]
;		--assert "true" = mold to url! #[true]
===end-group===
===start-group=== "to-file!"
	--test-- "to-file!-char!"
		--assert %a = to file! #"a"
	--test-- "to-file!-string!"
		--assert %foo = to file! "foo"
	--test-- "to-file!-string!"
		--assert %foo%20%20bar = to file! "foo  bar"
	--test-- "to-file!-integer!"
		--assert %0 = to file! 0
	--test-- "to-file!-integer!"
		--assert %123 = to file! 123
	--test-- "to-file!-integer!"
		--assert %256 = to file! 256
	--test-- "to-file!-float!"
		--assert %1.5 = to file! 1.5
	--test-- "to-file!-integer!"
		--assert %-1 = to file! -1
	--test-- "to-file!-float!"
		--assert %-1.5 = to file! -1.5
;	--test-- "to-file!-pair!"
;		--assert %1x2 = to file! 1x2
	--test-- "to-file!-word!"
		--assert %word = to file! test-word
	--test-- "to-file!-word!"
		--assert %'lit-word = to file! test-lit-word
	--test-- "to-file!-refinement!"
		--assert %/refinement = to file! /refinement
	--test-- "to-file!-path!"
		--assert %path/foo = to file! test-path
;	--test-- "to-file!-lit-path!"
;		--assert %'path/lit = to file! test-lit-path
	--test-- "to-file!-file!"
		--assert %/file/ = to file! %/file/
	--test-- "to-file!-issue!"
		--assert %#FF00 = to file! #FF00
	--test-- "to-file!-issue!"
		--assert %#00FF = to file! #00FF
	--test-- "to-file!-issue!"
		--assert %#hello = to file! #hello
	--test-- "to-file!-binary!"
		--assert %"" = to file! #{}
	--test-- "to-file!-binary!"
		--assert %abc = to file! #{616263}
	--test-- "to-file!-block!"
		--assert %"" = to file! []
	--test-- "to-file!-block!"
		--assert %12 = to file! [1 2]
	--test-- "to-file!-block!"
		--assert %123 = to file! [1 2 3]
	--test-- "to-file!-block!"
		--assert %ab = to file! ["a" "b"]
;	--test-- "to-file!-tuple!"
;		--assert %1.1.1 = to file! 1.1.1
	--test-- "to-file!-paren!"
		--assert %"" = to file! test-paren-1
	--test-- "to-file!-paren!"
		--assert %12 = to file! test-paren-2
;	--test-- "to-file!-tag!"
;		--assert %a = to file! <a>
	--test-- "to-file!-bitset!"
		--assert %make%20bitset!%20#%7B00%7D = to file! test-bitset
;	--test-- "to-file!-logic!"
;		--assert %true = to file! #[true]
===end-group===
===start-group=== "to-issue!"
	--test-- "to-issue!-char!"
		--assert #a = to issue! #"a"
	--test-- "to-issue!-string!"
		--assert #foo = to issue! "foo"
	--test-- "to-issue!-word!"
		--assert #word = to issue! test-word
	--test-- "to-issue!-word!"
		--assert #lit-word = to issue! test-lit-word
	--test-- "to-issue!-set-word!"
		--assert #set-word = to issue! test-set-word
	--test-- "to-issue!-get-word!"
		--assert #get-word = to issue! test-get-word
	--test-- "to-issue!-refinement!"
		--assert #refinement = to issue! /refinement
	--test-- "to-issue!-issue!"
		--assert #FF00 = to issue! #FF00
	--test-- "to-issue!-issue!"
		--assert #00FF = to issue! #00FF
	--test-- "to-issue!-issue!"
		--assert #hello = to issue! #hello
;	--test-- "to-issue!-logic!"
;		--assert #true = to issue! #[true]
===end-group===
===start-group=== "to-binary!"
	--test-- "to-binary!-char!"
		--assert #{61} = to binary! #"a"
	--test-- "to-binary!-string!"
		--assert #{666F6F} = to binary! "foo"
	--test-- "to-binary!-string!"
		--assert #{666F6F2020626172} = to binary! "foo  bar"
	--test-- "to-binary!-integer!"
		--assert #{00000000} = to binary! 0
	--test-- "to-binary!-integer!"
		--assert #{0000007B} = to binary! 123
	--test-- "to-binary!-integer!"
		--assert #{00000100} = to binary! 256
	--test-- "to-binary!-float!"
		--assert #{3FF8000000000000} = to binary! 1.5
	--test-- "to-binary!-integer!"
		--assert #{FFFFFFFF} = to binary! -1
	--test-- "to-binary!-float!"
		--assert #{BFF8000000000000} = to binary! -1.5
;	--test-- "to-binary!-url!"
;		--assert #{687474703A2F2F7265642D6C616E672E6F7267} = to binary! http://red-lang.org
	--test-- "to-binary!-file!"
		--assert #{2F66696C652F} = to binary! %/file/
	--test-- "to-binary!-binary!"
		--assert #{} = to binary! #{}
	--test-- "to-binary!-binary!"
		--assert #{616263} = to binary! #{616263}
	--test-- "to-binary!-block!"
		--assert #{} = to binary! []
	--test-- "to-binary!-block!"
		--assert #{0102} = to binary! [1 2]
	--test-- "to-binary!-block!"
		--assert #{010203} = to binary! [1 2 3]
	--test-- "to-binary!-block!"
		--assert #{6162} = to binary! ["a" "b"]
;	--test-- "to-binary!-tuple!"
;		--assert #{010101} = to binary! 1.1.1
;	--test-- "to-binary!-tag!"
;		--assert #{61} = to binary! <a>
;	--test-- "to-binary!-email!"
;		--assert #{666F6F40626F6F} = to binary! foo@boo
	--test-- "to-binary!-bitset!"
		--assert #{00} = to binary! test-bitset
===end-group===
===start-group=== "to-block!"
	--test-- "to-block!-char!"
		--assert block? to block! #"a"
		--assert {[#"a"]} = mold to block! #"a"
	--test-- "to-block!-string!"
		--assert block? to block! "foo"
		--assert {["foo"]} = mold to block! "foo"
	--test-- "to-block!-string!"
		--assert block? to block! "foo  bar"
		--assert {["foo  bar"]} = mold to block! "foo  bar"
	--test-- "to-block!-integer!"
		--assert block? to block! 0
		--assert "[0]" = mold to block! 0
	--test-- "to-block!-integer!"
		--assert block? to block! 123
		--assert "[123]" = mold to block! 123
	--test-- "to-block!-integer!"
		--assert block? to block! 256
		--assert "[256]" = mold to block! 256
	--test-- "to-block!-float!"
		--assert block? to block! 1.5
		--assert "[1.5]" = mold to block! 1.5
	--test-- "to-block!-integer!"
		--assert block? to block! -1
		--assert "[-1]" = mold to block! -1
	--test-- "to-block!-float!"
		--assert block? to block! -1.5
		--assert "[-1.5]" = mold to block! -1.5
;	--test-- "to-block!-pair!"
;		--assert block? to block! 1x2
;		--assert "[1x2]" = mold to block! 1x2
	--test-- "to-block!-word!"
		--assert block? to block! test-word
		--assert "[word]" = mold to block! test-word
	--test-- "to-block!-word!"
		--assert block? to block! test-lit-word
		--assert {['lit-word]} = mold to block! test-lit-word
	--test-- "to-block!-set-word!"
		--assert block? to block! test-set-word
		--assert "[set-word:]" = mold to block! test-set-word
	--test-- "to-block!-get-word!"
		--assert block? to block! test-get-word
		--assert "[:get-word]" = mold to block! test-get-word
	--test-- "to-block!-refinement!"
		--assert block? to block! /refinement
		--assert "[/refinement]" = mold to block! /refinement
	--test-- "to-block!-path!"
		--assert block? to block! test-path
		--assert "[path foo]" = mold to block! test-path
	--test-- "to-block!-lit-path!"
		--assert block? to block! test-lit-path
		--assert "[path lit]" = mold to block! test-lit-path
	--test-- "to-block!-set-path!"
		--assert block? to block! test-set-path
		--assert "[path set]" = mold to block! test-set-path
	--test-- "to-block!-get-path!"
		--assert block? to block! test-get-path
		--assert "[path get]" = mold to block! test-get-path
;	--test-- "to-block!-url!"
;		--assert block? to block! http://red-lang.org
;		--assert "[http://red-lang.org]" = mold to block! http://red-lang.org
	--test-- "to-block!-file!"
		--assert block? to block! %/file/
		--assert "[%/file/]" = mold to block! %/file/
	--test-- "to-block!-issue!"
		--assert block? to block! #FF00
		--assert "[#FF00]" = mold to block! #FF00
	--test-- "to-block!-issue!"
		--assert block? to block! #00FF
		--assert "[#00FF]" = mold to block! #00FF
	--test-- "to-block!-issue!"
		--assert block? to block! #hello
		--assert "[#hello]" = mold to block! #hello
	--test-- "to-block!-binary!"
		--assert block? to block! #{}
		--assert {[#{}]} = mold to block! #{}
	--test-- "to-block!-binary!"
		--assert block? to block! #{616263}
		--assert {[#{616263}]} = mold to block! #{616263}
	--test-- "to-block!-block!"
		--assert block? to block! []
		--assert "[]" = mold to block! []
	--test-- "to-block!-block!"
		--assert block? to block! [1 2]
		--assert "[1 2]" = mold to block! [1 2]
	--test-- "to-block!-block!"
		--assert block? to block! [1 2 3]
		--assert "[1 2 3]" = mold to block! [1 2 3]
	--test-- "to-block!-block!"
		--assert block? to block! ["a" "b"]
		--assert {["a" "b"]} = mold to block! ["a" "b"]
;	--test-- "to-block!-tuple!"
;		--assert block? to block! 1.1.1
;		--assert "[1.1.1]" = mold to block! 1.1.1
	--test-- "to-block!-paren!"
		--assert block? to block! test-paren-1
		--assert "[]" = mold to block! test-paren-1
	--test-- "to-block!-paren!"
		--assert block? to block! test-paren-2
		--assert "[1 2]" = mold to block! test-paren-2
;	--test-- "to-block!-tag!"
;		--assert block? to block! <a>
;		--assert "[<a>]" = mold to block! <a>
;	--test-- "to-block!-time!"
;		--assert block? to block! 10:00
;		--assert "[10:00]" = mold to block! 10:00
;	--test-- "to-block!-date!"
;		--assert block? to block! 16-Jun-2014/14:34:59+2:00
;		--assert "[16-Jun-2014/14:34:59+2:00]" = mold to block! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-block!-email!"
;		--assert block? to block! foo@boo
;		--assert "[foo@boo]" = mold to block! foo@boo
	--test-- "to-block!-bitset!"
		--assert block? to block! test-bitset
		--assert "[make bitset! #{00}]" = mold to block! test-bitset
	--test-- "to-block!-logic!"
		--assert block? to block! #[true]
		--assert "[true]" = mold to block! #[true]
	--test-- "to-block!-none!"
		--assert block? to block! #[none]
		--assert "[none]" = mold to block! #[none]
===end-group===
===start-group=== "to-tuple!"
;	--test-- "to-tuple!-issue!"
;		--assert 255.0.0 = to tuple! #FF00
;	--test-- "to-tuple!-issue!"
;		--assert 0.255.0 = to tuple! #00FF
;	--test-- "to-tuple!-binary!"
;		--assert 0.0.0 = to tuple! #{}
;	--test-- "to-tuple!-binary!"
;		--assert 97.98.99 = to tuple! #{616263}
;	--test-- "to-tuple!-block!"
;		--assert 0.0.0 = to tuple! []
;	--test-- "to-tuple!-block!"
;		--assert 1.2.0 = to tuple! [1 2]
;	--test-- "to-tuple!-block!"
;		--assert 1.2.3 = to tuple! [1 2 3]
;	--test-- "to-tuple!-tuple!"
;		--assert 1.1.1 = to tuple! 1.1.1
;	--test-- "to-tuple!-paren!"
;		--assert 0.0.0 = to tuple! test-paren-1
;	--test-- "to-tuple!-paren!"
;		--assert 1.2.0 = to tuple! test-paren-2
===end-group===
===start-group=== "to-paren!"
	--test-- "to-paren!-char!"
		--assert paren? to paren! #"a"
		--assert {(#"a")} = mold to paren! #"a"
	--test-- "to-paren!-string!"
		--assert paren? to paren! "foo"
		--assert {("foo")} = mold to paren! "foo"
	--test-- "to-paren!-string!"
		--assert paren? to paren! "foo  bar"
		--assert {("foo  bar")} = mold to paren! "foo  bar"
	--test-- "to-paren!-integer!"
		--assert paren? to paren! 0
		--assert "(0)" = mold to paren! 0
	--test-- "to-paren!-integer!"
		--assert paren? to paren! 123
		--assert "(123)" = mold to paren! 123
	--test-- "to-paren!-integer!"
		--assert paren? to paren! 256
		--assert "(256)" = mold to paren! 256
	--test-- "to-paren!-float!"
		--assert paren? to paren! 1.5
		--assert "(1.5)" = mold to paren! 1.5
	--test-- "to-paren!-integer!"
		--assert paren? to paren! -1
		--assert "(-1)" = mold to paren! -1
	--test-- "to-paren!-float!"
		--assert paren? to paren! -1.5
		--assert "(-1.5)" = mold to paren! -1.5
;	--test-- "to-paren!-pair!"
;		--assert paren? to paren! 1x2
;		--assert "(1x2)" = mold to paren! 1x2
	--test-- "to-paren!-word!"
		--assert paren? to paren! test-word
		--assert "(word)" = mold to paren! test-word
	--test-- "to-paren!-word!"
		--assert paren? to paren! test-lit-word
		--assert {('lit-word)} = mold to paren! test-lit-word
	--test-- "to-paren!-set-word!"
		--assert paren? to paren! test-set-word
		--assert "(set-word:)" = mold to paren! test-set-word
	--test-- "to-paren!-get-word!"
		--assert paren? to paren! test-get-word
		--assert "(:get-word)" = mold to paren! test-get-word
	--test-- "to-paren!-refinement!"
		--assert paren? to paren! /refinement
		--assert "(/refinement)" = mold to paren! /refinement
	--test-- "to-paren!-path!"
		--assert paren? to paren! test-path
		--assert "(path foo)" = mold to paren! test-path
	--test-- "to-paren!-lit-path!"
		--assert paren? to paren! test-lit-path
		--assert "(path lit)" = mold to paren! test-lit-path
	--test-- "to-paren!-set-path!"
		--assert paren? to paren! test-set-path
		--assert "(path set)" = mold to paren! test-set-path
	--test-- "to-paren!-get-path!"
		--assert paren? to paren! test-get-path
		--assert "(path get)" = mold to paren! test-get-path
;	--test-- "to-paren!-url!"
;		--assert paren? to paren! http://red-lang.org
;		--assert "(http://red-lang.org)" = mold to paren! http://red-lang.org
	--test-- "to-paren!-file!"
		--assert paren? to paren! %/file/
		--assert "(%/file/)" = mold to paren! %/file/
	--test-- "to-paren!-issue!"
		--assert paren? to paren! #FF00
		--assert "(#FF00)" = mold to paren! #FF00
	--test-- "to-paren!-issue!"
		--assert paren? to paren! #00FF
		--assert "(#00FF)" = mold to paren! #00FF
	--test-- "to-paren!-issue!"
		--assert paren? to paren! #hello
		--assert "(#hello)" = mold to paren! #hello
	--test-- "to-paren!-binary!"
		--assert paren? to paren! #{}
		--assert {(#{})} = mold to paren! #{}
	--test-- "to-paren!-binary!"
		--assert paren? to paren! #{616263}
		--assert {(#{616263})} = mold to paren! #{616263}
	--test-- "to-paren!-block!"
		--assert paren? to paren! []
		--assert "()" = mold to paren! []
	--test-- "to-paren!-block!"
		--assert paren? to paren! [1 2]
		--assert "(1 2)" = mold to paren! [1 2]
	--test-- "to-paren!-block!"
		--assert paren? to paren! [1 2 3]
		--assert "(1 2 3)" = mold to paren! [1 2 3]
	--test-- "to-paren!-block!"
		--assert paren? to paren! ["a" "b"]
		--assert {("a" "b")} = mold to paren! ["a" "b"]
;	--test-- "to-paren!-tuple!"
;		--assert paren? to paren! 1.1.1
;		--assert "(1.1.1)" = mold to paren! 1.1.1
	--test-- "to-paren!-paren!"
		--assert paren? to paren! test-paren-1
		--assert "()" = mold to paren! test-paren-1
	--test-- "to-paren!-paren!"
		--assert paren? to paren! test-paren-2
		--assert "(1 2)" = mold to paren! test-paren-2
;	--test-- "to-paren!-tag!"
;		--assert paren? to paren! <a>
;		--assert "(<a>)" = mold to paren! <a>
;	--test-- "to-paren!-time!"
;		--assert paren? to paren! 10:00
;		--assert "(10:00)" = mold to paren! 10:00
;	--test-- "to-paren!-date!"
;		--assert paren? to paren! 16-Jun-2014/14:34:59+2:00
;		--assert "(16-Jun-2014/14:34:59+2:00)" = mold to paren! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-paren!-email!"
;		--assert paren? to paren! foo@boo
;		--assert "(foo@boo)" = mold to paren! foo@boo
	--test-- "to-paren!-bitset!"
		--assert paren? to paren! test-bitset
		--assert "(make bitset! #{00})" = mold to paren! test-bitset
	--test-- "to-paren!-logic!"
		--assert paren? to paren! #[true]
		--assert "(true)" = mold to paren! #[true]
	--test-- "to-paren!-none!"
		--assert paren? to paren! #[none]
		--assert "(none)" = mold to paren! #[none]
===end-group===
===start-group=== "to-tag!"
;	--test-- "to-tag!-char!"
;		--assert <a> = to tag! #"a"
;	--test-- "to-tag!-string!"
;		--assert <foo> = to tag! "foo"
;	--test-- "to-tag!-string!"
;		--assert <foo  bar> = to tag! "foo  bar"
;	--test-- "to-tag!-integer!"
;		--assert <0> = to tag! 0
;	--test-- "to-tag!-integer!"
;		--assert <123> = to tag! 123
;	--test-- "to-tag!-integer!"
;		--assert <256> = to tag! 256
;	--test-- "to-tag!-float!"
;		--assert <1.5> = to tag! 1.5
;	--test-- "to-tag!-integer!"
;		--assert <-1> = to tag! -1
;	--test-- "to-tag!-float!"
;		--assert <-1.5> = to tag! -1.5
;	--test-- "to-tag!-pair!"
;		--assert <1x2> = to tag! 1x2
;	--test-- "to-tag!-word!"
;		--assert <word> = to tag! test-word
;	--test-- "to-tag!-word!"
;		--assert <lit-word> = to tag! test-lit-word
;	--test-- "to-tag!-set-word!"
;		--assert <set-word:> = to tag! test-set-word
;	--test-- "to-tag!-get-word!"
;		--assert <:get-word> = to tag! test-get-word
;	--test-- "to-tag!-refinement!"
;		--assert </refinement> = to tag! /refinement
;	--test-- "to-tag!-path!"
;		--assert <path/foo> = to tag! test-path
;	--test-- "to-tag!-lit-path!"
;		--assert <'path/lit> = to tag! test-lit-path
;	--test-- "to-tag!-set-path!"
;		--assert <path/set:> = to tag! test-set-path
;	--test-- "to-tag!-get-path!"
;		--assert <:path/get> = to tag! test-get-path
;	--test-- "to-tag!-url!"
;		--assert <http://red-lang.org> = to tag! http://red-lang.org
;	--test-- "to-tag!-file!"
;		--assert </file/> = to tag! %/file/
;	--test-- "to-tag!-issue!"
;		--assert <#FF00> = to tag! #FF00
;	--test-- "to-tag!-issue!"
;		--assert <#00FF> = to tag! #00FF
;	--test-- "to-tag!-issue!"
;		--assert <#hello> = to tag! #hello
;	--test-- "to-tag!-binary!"
;		--assert <> = to tag! #{}
;	--test-- "to-tag!-binary!"
;		--assert <abc> = to tag! #{616263}
;	--test-- "to-tag!-block!"
;		--assert <> = to tag! []
;	--test-- "to-tag!-block!"
;		--assert <12> = to tag! [1 2]
;	--test-- "to-tag!-block!"
;		--assert <123> = to tag! [1 2 3]
;	--test-- "to-tag!-block!"
;		--assert <ab> = to tag! ["a" "b"]
;	--test-- "to-tag!-tuple!"
;		--assert <1.1.1> = to tag! 1.1.1
;	--test-- "to-tag!-paren!"
;		--assert <> = to tag! test-paren-1
;	--test-- "to-tag!-paren!"
;		--assert <12> = to tag! test-paren-2
;	--test-- "to-tag!-tag!"
;		--assert <a> = to tag! <a>
;	--test-- "to-tag!-time!"
;		--assert <10:00> = to tag! 10:00
;	--test-- "to-tag!-date!"
;		--assert <16-Jun-2014/14:34:59+2:00> = to tag! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-tag!-email!"
;		--assert <foo@boo> = to tag! foo@boo
;	--test-- "to-tag!-bitset!"
;		--assert <make bitset! #{00}> = to tag! test-bitset
;	--test-- "to-tag!-logic!"
;		--assert <true> = to tag! #[true]
===end-group===
===start-group=== "to-time!"
;	--test-- "to-time!-integer!"
;		--assert 0:00 = to time! 0
;	--test-- "to-time!-integer!"
;		--assert 0:02:03 = to time! 123
;	--test-- "to-time!-integer!"
;		--assert 0:04:16 = to time! 256
;	--test-- "to-time!-float!"
;		--assert 0:00:01.5 = to time! 1.5
;	--test-- "to-time!-integer!"
;		--assert -0:00:01 = to time! -1
;	--test-- "to-time!-float!"
;		--assert -0:00:01.499999999 = to time! -1.5
;	--test-- "to-time!-block!"
;		--assert 1:02 = to time! [1 2]
;	--test-- "to-time!-block!"
;		--assert 1:02:03 = to time! [1 2 3]
;	--test-- "to-time!-paren!"
;		--assert 1:02 = to time! test-paren-2
;	--test-- "to-time!-time!"
;		--assert 10:00 = to time! 10:00
===end-group===
===start-group=== "to-date!"
;	--test-- "to-date!-block!"
;		--assert 1-Feb-0003 = to date! [1 2 3]
;	--test-- "to-date!-date!"
;		--assert 16-Jun-2014/14:34:59+2:00 = to date! 16-Jun-2014/14:34:59+2:00
===end-group===
===start-group=== "to-email!"
;	--test-- "to-email!-char!"
;		--assert a = to email! #"a"
;	--test-- "to-email!-string!"
;		--assert foo = to email! "foo"
;	--test-- "to-email!-integer!"
;		--assert 0 = to email! 0
;	--test-- "to-email!-integer!"
;		--assert 123 = to email! 123
;	--test-- "to-email!-integer!"
;		--assert 256 = to email! 256
;	--test-- "to-email!-float!"
;		--assert 1.5 = to email! 1.5
;	--test-- "to-email!-integer!"
;		--assert -1 = to email! -1
;	--test-- "to-email!-float!"
;		--assert -1.5 = to email! -1.5
;	--test-- "to-email!-pair!"
;		--assert 1x2 = to email! 1x2
;	--test-- "to-email!-word!"
;		--assert word = to email! test-word
;	--test-- "to-email!-word!"
;		--assert lit-word = to email! test-lit-word
;	--test-- "to-email!-set-word!"
;		--assert set-word: = to email! test-set-word
;	--test-- "to-email!-get-word!"
;		--assert :get-word = to email! test-get-word
;	--test-- "to-email!-refinement!"
;		--assert /refinement = to email! /refinement
;	--test-- "to-email!-path!"
;		--assert path/foo = to email! test-path
;	--test-- "to-email!-lit-path!"
;		--assert 'path/lit = to email! test-lit-path
;	--test-- "to-email!-set-path!"
;		--assert path/set: = to email! test-set-path
;	--test-- "to-email!-get-path!"
;		--assert :path/get = to email! test-get-path
;	--test-- "to-email!-url!"
;		--assert http://red-lang.org = to email! http://red-lang.org
;	--test-- "to-email!-file!"
;		--assert /file/ = to email! %/file/
;	--test-- "to-email!-issue!"
;		--assert #FF00 = to email! #FF00
;	--test-- "to-email!-issue!"
;		--assert #00FF = to email! #00FF
;	--test-- "to-email!-issue!"
;		--assert #hello = to email! #hello
;	--test-- "to-email!-binary!"
;		--assert  = to email! #{}
;	--test-- "to-email!-binary!"
;		--assert abc = to email! #{616263}
;	--test-- "to-email!-block!"
;		--assert  = to email! []
;	--test-- "to-email!-block!"
;		--assert 12 = to email! [1 2]
;	--test-- "to-email!-block!"
;		--assert 123 = to email! [1 2 3]
;	--test-- "to-email!-block!"
;		--assert ab = to email! ["a" "b"]
;	--test-- "to-email!-tuple!"
;		--assert 1.1.1 = to email! 1.1.1
;	--test-- "to-email!-paren!"
;		--assert  = to email! test-paren-1
;	--test-- "to-email!-paren!"
;		--assert 12 = to email! test-paren-2
;	--test-- "to-email!-tag!"
;		--assert a = to email! <a>
;	--test-- "to-email!-time!"
;		--assert 10:00 = to email! 10:00
;	--test-- "to-email!-date!"
;		--assert 16-Jun-2014/14:34:59+2:00 = to email! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-email!-email!"
;		--assert foo@boo = to email! foo@boo
;	--test-- "to-email!-logic!"
;		--assert true = to email! #[true]
===end-group===
===start-group=== "to-bitset!"
	--test-- "to-bitset!-char!"
		--assert bitset? to bitset! #"a"
		--assert "make bitset! #{00000000000000000000000040}" = mold to bitset! #"a"
	--test-- "to-bitset!-string!"
		--assert bitset? to bitset! "foo"
		--assert "make bitset! #{0000000000000000000000000201}" = mold to bitset! "foo"
	--test-- "to-bitset!-string!"
		--assert bitset? to bitset! "foo  bar"
		--assert "make bitset! #{000000008000000000000000620120}" = mold to bitset! "foo  bar"
	--test-- "to-bitset!-integer!"
		--assert bitset? to bitset! 0
		--assert "make bitset! #{}" = mold to bitset! 0
	--test-- "to-bitset!-integer!"
		--assert bitset? to bitset! 123
		--assert "make bitset! #{00000000000000000000000000000000}" = mold to bitset! 123
	--test-- "to-bitset!-integer!"
		--assert bitset? to bitset! 256
		--assert {make bitset! #{0000000000000000000000000000000000000000000000000000000000000000}} = mold to bitset! 256
;	--test-- "to-bitset!-url!"
;		--assert bitset? to bitset! http://red-lang.org
;		--assert "make bitset! #{0000000000070020000000004D8BA8}" = mold to bitset! http://red-lang.org
	--test-- "to-bitset!-file!"
		--assert bitset? to bitset! %/file/
		--assert "make bitset! #{0000000000010000000000000648}" = mold to bitset! %/file/
	--test-- "to-bitset!-binary!"
		--assert bitset? to bitset! #{}
		--assert "make bitset! #{}" = mold to bitset! #{}
	--test-- "to-bitset!-binary!"
		--assert bitset? to bitset! #{616263}
		--assert "make bitset! #{616263}" = mold to bitset! #{616263}
	--test-- "to-bitset!-block!"
		--assert bitset? to bitset! []
		--assert "make bitset! #{}" = mold to bitset! []
	--test-- "to-bitset!-block!"
		--assert bitset? to bitset! [1 2]
		--assert "make bitset! #{60}" = mold to bitset! [1 2]
	--test-- "to-bitset!-block!"
		--assert bitset? to bitset! [1 2 3]
		--assert "make bitset! #{70}" = mold to bitset! [1 2 3]
	--test-- "to-bitset!-block!"
		--assert bitset? to bitset! ["a" "b"]
		--assert "make bitset! #{00000000000000000000000060}" = mold to bitset! ["a" "b"]
;	--test-- "to-bitset!-tag!"
;		--assert bitset? to bitset! <a>
;		--assert "make bitset! #{00000000000000000000000040}" = mold to bitset! <a>
;	--test-- "to-bitset!-email!"
;		--assert bitset? to bitset! foo@boo
;		--assert "make bitset! #{0000000000000000800000002201}" = mold to bitset! foo@boo
===end-group===
===start-group=== "to-logic!"
	--test-- "to-logic!-char!"
		--assert true = to logic! #"a"
	--test-- "to-logic!-string!"
		--assert true = to logic! "foo"
	--test-- "to-logic!-string!"
		--assert true = to logic! "foo  bar"
	--test-- "to-logic!-integer!"
		--assert true = to logic! 0
	--test-- "to-logic!-integer!"
		--assert true = to logic! 123
	--test-- "to-logic!-integer!"
		--assert true = to logic! 256
	--test-- "to-logic!-float!"
		--assert true = to logic! 1.5
	--test-- "to-logic!-integer!"
		--assert true = to logic! -1
	--test-- "to-logic!-float!"
		--assert true = to logic! -1.5
;	--test-- "to-logic!-pair!"
;		--assert true = to logic! 1x2
	--test-- "to-logic!-word!"
		--assert true = to logic! test-word
	--test-- "to-logic!-word!"
		--assert true = to logic! test-lit-word
	--test-- "to-logic!-set-word!"
		--assert true = to logic! test-set-word
	--test-- "to-logic!-get-word!"
		--assert true = to logic! test-get-word
	--test-- "to-logic!-refinement!"
		--assert true = to logic! /refinement
	--test-- "to-logic!-path!"
		--assert true = to logic! test-path
	--test-- "to-logic!-lit-path!"
		--assert true = to logic! test-lit-path
	--test-- "to-logic!-set-path!"
		--assert true = to logic! test-set-path
	--test-- "to-logic!-get-path!"
		--assert true = to logic! test-get-path
;	--test-- "to-logic!-url!"
;		--assert true = to logic! http://red-lang.org
	--test-- "to-logic!-file!"
		--assert true = to logic! %/file/
	--test-- "to-logic!-issue!"
		--assert true = to logic! #FF00
	--test-- "to-logic!-issue!"
		--assert true = to logic! #00FF
	--test-- "to-logic!-issue!"
		--assert true = to logic! #hello
	--test-- "to-logic!-binary!"
		--assert true = to logic! #{}
	--test-- "to-logic!-binary!"
		--assert true = to logic! #{616263}
	--test-- "to-logic!-block!"
		--assert true = to logic! []
	--test-- "to-logic!-block!"
		--assert true = to logic! [1 2]
	--test-- "to-logic!-block!"
		--assert true = to logic! [1 2 3]
	--test-- "to-logic!-block!"
		--assert true = to logic! ["a" "b"]
;	--test-- "to-logic!-tuple!"
;		--assert true = to logic! 1.1.1
	--test-- "to-logic!-paren!"
		--assert true = to logic! test-paren-1
	--test-- "to-logic!-paren!"
		--assert true = to logic! test-paren-2
;	--test-- "to-logic!-tag!"
;		--assert true = to logic! <a>
;	--test-- "to-logic!-time!"
;		--assert true = to logic! 10:00
;	--test-- "to-logic!-date!"
;		--assert true = to logic! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-logic!-email!"
;		--assert true = to logic! foo@boo
	--test-- "to-logic!-bitset!"
		--assert true = to logic! test-bitset
	--test-- "to-logic!-logic!"
		--assert true = to logic! #[true]
	--test-- "to-logic!-none!"
		--assert false = to logic! #[none]
===end-group===
===start-group=== "to-none!"
	--test-- "to-none!-char!"
		--assert none = to none! #"a"
	--test-- "to-none!-string!"
		--assert none = to none! "foo"
	--test-- "to-none!-string!"
		--assert none = to none! "foo  bar"
	--test-- "to-none!-integer!"
		--assert none = to none! 0
	--test-- "to-none!-integer!"
		--assert none = to none! 123
	--test-- "to-none!-integer!"
		--assert none = to none! 256
	--test-- "to-none!-float!"
		--assert none = to none! 1.5
	--test-- "to-none!-integer!"
		--assert none = to none! -1
	--test-- "to-none!-float!"
		--assert none = to none! -1.5
;	--test-- "to-none!-pair!"
;		--assert none = to none! 1x2
	--test-- "to-none!-word!"
		--assert none = to none! test-word
	--test-- "to-none!-word!"
		--assert none = to none! test-lit-word
	--test-- "to-none!-set-word!"
		--assert none = to none! test-set-word
	--test-- "to-none!-get-word!"
		--assert none = to none! test-get-word
	--test-- "to-none!-refinement!"
		--assert none = to none! /refinement
	--test-- "to-none!-path!"
		--assert none = to none! test-path
	--test-- "to-none!-lit-path!"
		--assert none = to none! test-lit-path
	--test-- "to-none!-set-path!"
		--assert none = to none! test-set-path
	--test-- "to-none!-get-path!"
		--assert none = to none! test-get-path
;	--test-- "to-none!-url!"
;		--assert none = to none! http://red-lang.org
	--test-- "to-none!-file!"
		--assert none = to none! %/file/
	--test-- "to-none!-issue!"
		--assert none = to none! #FF00
	--test-- "to-none!-issue!"
		--assert none = to none! #00FF
	--test-- "to-none!-issue!"
		--assert none = to none! #hello
	--test-- "to-none!-binary!"
		--assert none = to none! #{}
	--test-- "to-none!-binary!"
		--assert none = to none! #{616263}
	--test-- "to-none!-block!"
		--assert none = to none! []
	--test-- "to-none!-block!"
		--assert none = to none! [1 2]
	--test-- "to-none!-block!"
		--assert none = to none! [1 2 3]
	--test-- "to-none!-block!"
		--assert none = to none! ["a" "b"]
;	--test-- "to-none!-tuple!"
;		--assert none = to none! 1.1.1
	--test-- "to-none!-paren!"
		--assert none = to none! test-paren-1
	--test-- "to-none!-paren!"
		--assert none = to none! test-paren-2
;	--test-- "to-none!-tag!"
;		--assert none = to none! <a>
;	--test-- "to-none!-time!"
;		--assert none = to none! 10:00
;	--test-- "to-none!-date!"
;		--assert none = to none! 16-Jun-2014/14:34:59+2:00
;	--test-- "to-none!-email!"
;		--assert none = to none! foo@boo
	--test-- "to-none!-bitset!"
		--assert none = to none! test-bitset
	--test-- "to-none!-logic!"
		--assert none = to none! #[true]
	--test-- "to-none!-none!"
		--assert none = to none! #[none]
===end-group===


~~~end-file~~~
