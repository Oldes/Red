Red [
	Title:   "Red minimal test script"
	Author:  "Nenad Rakocevic"
	File: 	 %hello.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2012 Nenad Rakocevic. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/dockimbel/Red/blob/master/BSL-License.txt
	}
]


print "Hello, world!"
print "Χαῖρε, κόσμε!"
print "你好, 世界"
print "Dobrý den světe"

ansi-inverse: "^[[7m"
ansi-red:     "^[[37;41m"
ansi-reset:   "^[[0m"


print [ansi-inverse "Inverse text" ansi-inverse]
print [ansi-red "Some Red text" ansi-reset]


