---
published: true
layout: post
categories: 
- markup
- AJAX
comments: true

title: Beyond the page view, measuring interactions within the page
author: Fiann O'Hagan
--- 

<div class="pullout note">
  <p>Last time, we looked at why <a href="/blog/2009/10/17/universal_tag_or_universal_data/">shared data is more important than a Universal Tag</a>. Simply putting the library code for each tag onto the page doesn't solve the problem, if you still have to re-declare the same page-specific in proprietary formats.</p>
  <p>In this article, I am addressing the language for events that happen after the page has loaded.</p>
</div>

Much of the metadata that is traditionally used for web analytics is contained in the page, either in JS variable declarations, or sometimes calculated in custom code for the page.

But the increase of Flash, AJAX, and online video means that just opening the page doesn't tell us nearly enough about user engagement. 

Increasingly, page views are no longer even considered to be the most useful measure of user engagement. In 2007, [Neilsen NetRatings stopped measuring page views][nnr] in favor of time on site.

 [nnr]: http://www.readwriteweb.com/archives/tyranny_of_the_page_view.php

This is still not a complete industry consensus. Also in 2007, the Web Analytics Association published [26 core web metrics][waa], and all of these are calculated from the page view as the fundamental event. 
 
 [waa]: http://www.kaushik.net/avinash/2007/08/web-analytics-standards-26-new-metrics-definitions.html

It should be obvious that neither page view based metrics, nor time on site, tell you anything about what the user is doing while they have an AJAX or other rich media page open in the browser. And if we want to understand user behavior, we have to start by measuring that behavior.

## Not all data is in the markup on the page ##

In a [previous post][data], I suggested [microformats][mf] as a way of expressing page markup. But the rich media interactions are, by definition, happening after the page has loaded, and therefore cannot be included when the page is generated.

<div class="pullout info">
  <p>There are actually <strong>two separate standards</strong> needed. One is for the events that are encoded in the page when it's loaded. The second is for events in the script layer as the page is running in the browser.</p>
</div>

It took us quite a long time to work this out. And to the best of my knowledge, it's not something that has been recognized by any of the universal tag vendors yet. Yet it is shaping up to be one of the most important features of the jsHub architecture, and it all comes down to have a completely event based architecture from the start.

Here's how the jsHub tag works: we have parsers for different data formats (including our preferred microformats). The parser reads the page, and when it finds some data that it knows how to interpret, it fires an event. 

Crucially, we have an API that does that same thing. When something interesting occurs, such as a user interaction, you can trigger an event in exactly the same way. And so events that happen after the page is loaded are treated in the same way as events that happen during the page load.

Our events are in a standard format. Once we realized the need to standardize this, we decoupled the format of the JavaScript object representing the event, from the microformat markup representing the same event. For example not all the field names are necessarily the same. This means that there's a bit of extra mapping required. But it also means that the JavaScript event objects are internally consistent, and the data is human-readable. And it means that any form of markup can be used to generate events in the same format. So, for example, the `page-view` event always has a field called `name`, but the source of that field might be `s.pageName` if the data was being parsed from Omniture markup.

## What's in an event? ##

First and foremost, every event has a type. This is a big change from many of the analytics vendors' current practice. For example, to record an AJAX event in Webtrends, you would call `dcsMultiTrack()` and in SiteCatalyst, you call `s.t()` or `s.tl()`. Both of these functions take a page name or URL, so what you are recording is a page-view-that's-not-really-a-page-view.

In jsHub, we have a growing list of standard event types (documentation on these is in the pipeline). We have a `page-view` event, of course, but we also have a `product-search` event, a `product-promotion` event that happens when the user is shown recommended products on the site, and a `purchase` event at the end of the checkout funnel. 

These are all real events, with the same validity as a page view, rather than being inferred from properties of page view events, or fake page view events. 

Secondly, events have zero or more attributes. A `page-view` has a `name`, a `title` and a `referrer`. A search event has search terms. Events may also have custom attributes, which are set by the developers who create the page.

All of these events can be mapped on to the underlying event structure of the web analytics provider. So a `product-view` event in the jsHub markup might (for example) be mapped to an `eVar` property of a page view event in SiteCatalyst.

The goal for us is to keep as much semantic richness in the data, for as long as possible, before mapping it on to a specific vendor format.