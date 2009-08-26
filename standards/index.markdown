---
layout: projects
title: Markup standards
tab: home
---

<p class="path noprint">
  <a class="pathentry" href="/">Home</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/standards/">Standards for page metadata markup</a> 
  <br style="clear: both" />
</p>

# Standards for page metadata markup #

There are many products in the market that require data about user activity to provide their services. Web analytics are one big consumer, but there are also recommendations engines, behavioral targeting, and many other categories.

jsHub believes that the additional effort in deploying each of these is an unnecessary burden on the industry and on our clients. 

## What do we want to standardize? ##
There are two places where we want to standardize the data that is collected from the page.

The first is **static metadata in the page**, things like the name and category of the page. This information is used to build web analytics reports, and also used by behavioral targeting and other systems to understand what pages are viewed.

The second area is **events that occur after page load**, for example when watching a video or interacting with AJAX content. 

## Static metadata ##
Static metadata is typically declared using JavaScript variables declared in the page, or in external files. 

jsHub is proposing a new alternative to the use of JavaScript variables, based on HTML microformats. This declares information within the HTML document, rather than in a script language. This has several advantages, because the data becomes part of the page, rather than a separate entity. This enables the data to be declared once and then re-used by multiple consumers, particularly search engines which are now using microformat data.

There will be a number of standards which together define the **common core of data** used by all applications. Vendors will then be free to define product-specific extensions as necessary where the data is not part of the common core.

For more information about microformat based markup, see the [markup project page](/projects/markup/). 

The [introduction to microformats](/projects/markup/introduction.html) provides a lot more background to the approach we are taking.

## Dynamic event data ##
Events that occur after the page has loaded cannot be declared in the HTML for obvious reasons. These events are represented in script, via a standard API.

The dynamic event standard consists of a dictionary of **standard events** covering the common core of events required for many products, together with a structure for defining event objects in JavaScript. The standard also defines an API for script in the page to call when an event is triggered, for example when a button is clicked.

For more information about event data capture, see the [event project page](/projects/events/).

## Standard container for vendor data capture ##
jsHub is also creating a reference implementation of a tag that can read these data types. The jsHub tag is plugin based, and allows vendors to easily provide a plugin that can speak to their systems.

This allows enterprises to deploy a single container tag file, and then simply add the relevant plugins when they wish to deploy a new product on the site.

For more information on the reference implementation of the tag, see the [tag project page](/projects/jshub/).

# Join the process #
If you are involved in markup, either as a vendor working on products that need to consume data, or in publishing the data on sites, then please join the discussion.

The standards are being actively discussed through a Google Groups mailing list. Please join us to discuss jsHub projects, ask questions, talk about javascript, or announce your plugins.

[jsHub standards mailing list](http://groups.google.com/group/jshub/) - discussions regarding the jsHub.org projects, proposals and roadmap. The list and archive are currently private, but anyone can request membership. 

<!-- raw html to add Google Groups sign-up -->
<form action="http://groups.google.com/group/jshub/boxsubscribe" style="padding-left: 1em">
<label>Email address: <input type="text" name="email" /></label>
<input type="submit" name="sub" value="Subscribe (groups.google.com)" />
</form>

[jsHub users mailing list](http://groups.google.com/group/jshub-users/) - this is the public list and the best place to post if you have general questions or concerns. Also, if you've built a site that uses jsHub, or would like to announce a new plugin, this is the place to do it. 

<!-- raw html to add Google Groups sign-up -->
<form action="http://groups.google.com/group/jshub-users/boxsubscribe" style="padding-left: 1em">
<label>Email address: <input type="text" name="email" /></label>
<input type="submit" name="sub" value="Subscribe (groups.google.com)" />
</form>

**Please note that lists are moderated (to prevent spam). Your first messages may take a few hours to get through, but future messages will show up instantly once you are out of the new-member-is-moderated policy.**
