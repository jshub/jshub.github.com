---
layout: projects
title: Metadata Markup Project 
---

<p class="path noprint">
  <a class="pathentry" href="/">Home</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects/">Projects</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects/markup/">Microformat markup</a> 
  <br style="clear: both" />
</p>


# Proposal for a markup standard #

jsHub proposes a new syntax for declaring data about the page that a user is viewing. The new syntax is based on HTML microformats, and declares the data in the HTML of the page, rather than in JavaScript variables.

The new markup standard we're proposing is captured in our [hPage draft specification](/hPage).

If you're new to microformats you may also want to read our [introduction to microformat markup](./introduction.html).

## Why HTML microformats? ##
HTML microformats are a set of simple design principles for marking up information semantically. Microformats use well known class names on HTML elements to tell the software parsing the page what the data in the page means. Microformats avoid the use of non-HTML markup (e.g. XML), providing a very low barrier to entry for page authors to include the markup in their content.

There are good introductions to microformats at [microformats.org](http://microformats.org/) and [on Wikipedia](http://en.wikipedia.org/wiki/Microformats).

Microformats are a great alternative to !JavaScript variables for carrying this data because they exist inline with the content of the page, because they are accessible to staff who are not JS programmers, and because they are available to search engines and other consumers of the content to parse.

## How can I get started? ##

The first place to look is the [hPage draft specification](/hPage). 

hPage is the term for the microformat data about a page. The spec describes how to place an hPage on a page, and the fields that can declared within it.

The specification document shows examples of how hPage can be in some common implementation scenarios.

## What does hPage look like? ##
For more examples of hPage implementation, take a look at the [demo store](/projects/demos/), which is a fully featured retail site (although it doesn't actually trade). The site has examples of hPage markup on each page - showing how to specify page names, categories, etc.
