---
layout: projects
title: jsHub Tag 
ribbon: true
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


# Developer information #
If you are interested in how the code works, then please read on.

## Plugin architecture and extensibility ##
The biggest change with the jsHub architecture is that it breaks the tight coupling between capturing data from the page and sending the data to a server. 

Traditionally, sites have several (sometimes, very many) separate tags on the page.

![Multiple tags on a single page](/images/jshub/plugin_architecture_before.png)

Each of the tags will collect information from the page, and each one will then create a request for a single pixel image from the server. Each of the tags requires similar information, but the data that is sent is in a separate proprietary format in each case.

The jsHub tag challenges this approach, by using a single central tag, the "hub", with a collection of plugins that can speak to each server in the appropriate format. This means that the same tag can support multiple different formats of markup on the same page, and multiple servers for different products. 

![jsHub plugin architecture](/images/jshub/plugin_architecture_after.png)

The jsHub tag doesn't attempt to process or understand the formats of different vendors' products. Instead, it provides a framework for vendors to supply their own plugins to support their products, with a common API for sharing the data between them.

A customer can implement the tag to deploy one product. If the customer wants to deploy another product after that only a plugin needs to be added. No re-tagging of the site would be needed so customers and vendors both benefit from a huge reduction in time and effort to deploy tags across the site.

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

The jsHub project includes sample plugins for collecting data from the page, and for transmitting data to the server. 

There is an example plugin for reading markup on the page:

 * [hPage-plugin.js](https://github.com/jshub/jshub-core/blob/master/app/javascripts/data-capture/hPage-plugin.js), a reference implementation of the [hPage specification](/hPage/)

We currently support plugins for two commercial services in production.

 * [Causata](http://www.causata.com/) provides real-time customer intelligence. They also help to sponsor jsHub.
 * [Google Analytics](http://www.google.com/analytics/), the free web analytics service. Note that jsHub does not integrate fully with Google Analytics. Instead, the plugin code places the normal tag for GA onto the page, and then maps jsHub events on to the tag.

For developers, there are two example data transport plugins:

 * [sample-get-plugin.js](http://github.com/jshub/jshub-core/blob/master/app/javascripts/data-transport/sample-get-plugin.js), a starting point for creating a plugin to send messages using a standard single pixel image
 * [sample-post-plugin.js](http://github.com/jshub/jshub-core/blob/master/app/javascripts/data-transport/sample-post-plugin.js), a starting point for creating a plugin to send messages by posting a form

These are extensively commented and provide a simple starting point for developers to begin creating plugins for other products.

# How can I contribute? #

**If you want to contribute to the code,** you should start by [downloading](http://github.com/jshub/jshub-core/downloads/) the developer bundle, or [fork the code on Github](http://github.com/jshub/jshub-core/tree/master).

The developer application is a Ruby on Rails application that contains the code, the tests, and some scripts to run the tests from the command line. You can also see the [unit tests online](/core/), running from the same application.

Please send any feedback, bug reports or comments to <info@jshub.org> to get through to one of the team. 

Thanks!