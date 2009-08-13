---
layout: about
title: Enterprises
---

<p class="path noprint">
  <a class="pathentry" href="/">Home</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/enterprises/">jsHub benefits for enterprises</a> 
  <br style="clear: both" />
</p>

# How does jsHub help the enterprise? #

The average enterprise website contains more than one JavaScript data collection on the homepage, and sometimes many more on landing pages deeper in the site.

Each of these tags represents **redundant, duplicate data**. And each instance of duplicate data is both wasted effort from the team maintaining the page, and another place where data that should be identical may get out of synch.

jsHub helps to minimize the cost of implementing new tag-based products on your site, by providing a practical Don't Repeat Yourself solution to deploying the markup.

## Why is tagging so expensive? ##

Deploying a tag-based solution on your site typically requires three stages.
 1. Deploy one or more JavaScript library files on your site or Content Delivery Network.
 2. Place a reference on each page to include the library into the page.
 3. Deploy page-specific markup on to each page where it is required.

Typically, stage 1 is very simple, and no more time consuming than adding a new image to the site.

Stage 2 is usually quite simple as well. A well designed site with an effective CMS will have a repeated template element where the script include can be added, usually in a footer which is repeated across the site. The exception to this is where a complex site is hosted in multiple locations and maintained by different teams, in which case there may not be a single location that can be changed. Still, the number of files touched is generally low.

Stage 3 is the very expensive part of the implementation. There are a couple of reasons why sites need to declare page-specific metadata. The first reason is that certain pages contain information which is not in the URL. For example, on ecommerce pages, it may be necessary to declare the products being viewed. 

The second reason to declare custom metadata is the situation where the URL structure is not "clean" enough to derive a mapping from URLs to separate pages. For example, some CMS systems and dynamic apps may include path components in the URL such as a session ID, so that different users viewing the same page do not report the same URL. Other systems may use part of the query string to define the page to be viewed.

Where there is a requirement for page-specific data, it can be necessary for thousands of pages to be touched individually, or for custom code to be developed to perform an automated URL mapping on certain areas of the site. Both of these add time and expense to the implementation.

## An open standard, not another Universal Tag ##

Several products function as a 'Universal Tag', by using a single include on the page to deploy more than one tag library. This removes (or greatly reduces) the effort in stage 2 and 3 of the implementation of subsequent products on the site.

One way of doing this is to piggy-back on an existing tag which has been deployed on the site. This is often a web analytics tag, as these have wide coverage across all pages of the site. 

Another way of providing a Universal Tag is to provide a dedicated 'container tag', which then wraps multiple functional tags. There are several solutions that provide a container for multiple ad network tracking tags.

All these container solutions have one thing in common: the data is controlled by a single vendor. Any metadata about the page is declared in the vendor's proprietary format, making it expensive to migrate to another provider. The vendor then controls the interface between the site and the other, wrapped, products.

**jsHub keeps you in control of your data.** We are providing a vendor-neutral format for declaring data, so you can declare data once, and it can be read by any vendor that supports it. This addresses the cost of stage 3, and removes the lock-in of having your data in a proprietary format.

Secondly, we provide a new type of tag. Vendors can provide plugins to this tag to deploy on the site, addressing the cost of stage 2 of the deployment process. This is different from the classic Universal Tag approach of wrapping standard tag code in a deployment container. The plugin architecture provides a common code core for all plugins so the overall page weight is reduced. You, the site owner, remain in control of the tag and can add or remove plugins directly. 

For more information about these, see the [markup project](/projects/markup/) and [jsHub tag project](/projects/jshub/) pages.