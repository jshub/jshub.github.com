---
layout: projects
title: jsHub Tag 
---

<p class="path noprint">
  <a class="pathentry" href="/">Home</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects">Projects</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects/jshub">jsHub Tag</a> 
  <br style="clear: both" />
</p>


# jsHub tag #

The jsHub tag is a fresh approach to the JavaScript "tag" used by many web analytics products and other products that need to collect data on end user behavior.

**Not the kind of tag you find in a tag cloud** <br/>
A tag in this sense is a script that runs when the page is loaded, and collects data from the page that is being viewed. The data depends on the page, but it will typically include a page name or URL, plus some other metadata. It's the not a tag in the sense of a category label describing the page.

## Getting started ##

**If you are a website owner and want to use the tag on your site,** go to the configurator. You just choose the plugins you need for your site, and click "Download".

 * [Configure a jsHub tag](/configurator/)

**If you want to understand the tag and the markup more in practice,** start with the [demo store](/retail2/), and see some examples of markup in the page. There will be more implementation guides on the site soon.

# Developer information #
If you are interested in how the code works, then please read on.

## Plugin architecture and extensibility ##
The biggest change with the jsHub architecture is that it breaks the tight coupling between capturing data from the page and sending the data to a server. This means that the same tag can support multiple different formats of markup on the same page, and multiple formats of data collection server for different products. 

![jsHub plugin architecture](/images/jshub/jsHub_plugin_architecture.png)

The jsHub tag doesn't attempt to process or understand the formats of different vendors' products. Instead, it provides a framework for vendors to supply their own plugins to support their products, with a common API for sharing the data between them.

A customer can implement the tag to deploy one product. If the customer wants to deploy another product after that only a plugin needs to be added. No re-tagging of the site would be needed so customers and vendors both benefit from a huge reduction in time and effort to deploy tags across the site.

## Built on jQuery ##
The jsHub project is built on top of the [jQuery library](http://jquery.com/). jQuery is a very robust and high performance cross-platform library for manipulating HTML. jsHub uses jQuery to access microformat markup from the page document object model.

Most of the microformat parsing library is implemented as jQuery selectors, and so will be familiar to developers who have used jQuery before.

## Robust, well tested, open source code ##
Traditionally it has been difficult to test JavaScript thoroughly. Unlike server applications, the script must run in a great variety of different environments, on different browsers and operating systems, and shares a global namespace with other code on the page. There has not been anything nearly equivalent to the robust automated tools for testing Java and other server code.

We have built a new test automation framework to test the jsHub tag. The code has a very high level of test coverage, both of code units, and of functional scenarios such as malformed markup. Unlike most existing tag code in the market, the behavior of the code is very well defined even when the markup is ambiguous.

The testing is based on four existing projects, brought together in a novel way for jsHub:
 * [Yahoo's YUI Test](http://developer.yahoo.com/yui/3/yuitest/) provides a test runner and a core set of assertions for testing JavaScript code in the browser
 * [Env.js](http://github.com/thatcher/env-js/tree/master) provides a simulated browser, which allows us to run all of the tests in one go very quickly from the command line
 * [Hudson](https://hudson.dev.java.net/) is a continuous integration server. The jsHub project runs a Hudson server, which builds the code and runs all the tests every time we commit a change to the version control repository.
 * [Litmus](http://litmusapp.com/) is a cross-browser testing environment. Primarily intended for UI developers to check their pages look the same in all browsers, we use Litmus to run all of the tests in 20+ browser / OS combinations. Our cross browsers tests are run every night.

There are currently over 120 tests for the code which are run automatically, across all our supported environments, whenever we make a change to the code. 

## Tools ##
Use [the tag configurator](/configurator/) to create a tag configuration with the plugins needed for your site.

jsHub also comes with the [Tag Inspector](/projects/inspector/), which allows site developers and editors to see exactly what data is being collected from their pages. The inspector gives a simple and friendly way to see the tag is running and debug the markup on the site. 

## Simplicity for plugin developers ##
The jsHub core hub provides a simple event based API for plugins to communicate with. A plugin simply needs to `bind` (subscribe to) the events that is it interested in, and `trigger` events that is has created.

The jsHub project includes sample plugins for collecting data from the page, and for transmitting data to the server. There are currently five example plugins available. There are two plugins for reading markup on the page:
 * [hPage-plugin.js](https://github.com/jshub/jshub/blob/b4172aca9694fe671a9d5a51272db080b8f00f89/app/javascripts/data-capture/hPage-plugin.js), a reference implementation of the [hPage specification](/hPage/)
 * [google-analytics-markup-plugin.js](https://github.com/jshub/jshub/blob/b4172aca9694fe671a9d5a51272db080b8f00f89/app/javascripts/data-capture/google-analytics-markup-plugin.js), an illustration of how to collect information from existing markup contained in JS variables and function calls

There are three example data transport plugins:
 * [Mixpanel data transport plugin](https://github.com/jshub/jshub/blob/b4172aca9694fe671a9d5a51272db080b8f00f89/app/javascripts/data-transport/sample-get-plugin.js), which can send data to the [Mixpanel](http://mixpanel.com/) service. This plugin allows you to collect event data and report on it in Mixpanel.
 * [sample-get-plugin.js](https://github.com/jshub/jshub/blob/b4172aca9694fe671a9d5a51272db080b8f00f89/app/javascripts/data-transport/sample-get-plugin.js), a starting point for creating a plugin to send messages using a standard single pixel image
 * [sample-post-plugin.js](https://github.com/jshub/jshub/blob/b4172aca9694fe671a9d5a51272db080b8f00f89/app/javascripts/data-transport/sample-post-plugin.js), a starting point for creating a plugin to send messages by posting a form

These are extensively commented and provide a simple starting point for developers to begin creating plugins for other products.

# How can I contribute? #

**If you want to contribute to the code,** you should start by [downloading](/download/) the developer bundle, or [fork the code on Github](https://github.com/jshub/jshub/tree/master).

The developer application is a Ruby on Rails application that contains the code, the tests, and some scripts to run the tests from the command line. You can also see the [unit tests online](/core), running from the same application.

Please send any feedback, bug reports or comments to <info@jshub.org> to get through to one of the team. Thanks!