---
published: true
layout: post
categories: 
- site news
comments: true

title: Announcing release 1.1
author: Fiann O'Hagan
--- 

Well it's been a while since we had a release, because I have been spending much of my time recently getting jsHub tags deployed on some live sites.

The code is now at version 1.1. You can see the [source code][src] hosted on Github, and you can [try the tests][tests] from right here in your browser.

 [src]: http://github.com/jshub/jshub-core/tree/v1.1.0/app/javascripts
 [tests]: https://jshub.org/core/test/javascript

According our continuous integration server, we have 32 HTML pages of YUI test code, containing 229 test cases. 

You can run the tests individually from any browser. You can also run them from the command line using `rake test:javascripts` and I am now using the rather wonderful [Johnson][johnson] gem to execute [env.js][envjs] in a Spidermonkey JavaScript engine.

 [johnson]: http://github.com/jbarnette/johnson
 [envjs]: http://github.com/smparkes/env-js

This is *much* faster than the previous method of executing the tests using the Rhino JavaScript engine. 

Give it a whirl!