---
published: true
layout: post
categories: 
- markup
- microformats
comments: true

title: Universal Tag or Universal Data?
author: Fiann O'Hagan
--- 

<div class="pullout note">
  <p>Last time, I set the scene with <a href="/blog/2009/10/16/what_is_a_universal_tag/">a basic introduction</a> to the idea of a Universal Tag. In this post, I'd like to explore a deeper but less commonly discussed issue, of the data that is collected by the Universal Tag.</p>
</div>

## In the beginning, was the URL ##

Early web analytics was really designed for IT professionals who needed to answer questions like "How many web servers do I need in order to handle my traffic?" The basic unit of currency was the *hit*, a request to the web server. When early web sites used to talk about the number of hits they were getting, they counted all the images and other components of the page.

In the early 2000s, web analytics shifted focus, and was purchased by marketing teams responsible for the content of the site, rather than IT teams responsible for delivery. 

I worked on one of those products from 2001, at Touch Clarity. Parts of the web analytics tool we built live on as [Sophus3 eMetrics][sophus].

 [sophus]: http://www.sophus3.co.uk/

A big part of the shift was that it was now important to measure the what the customer experienced. This is a shift which is very much still going on, but the first stage was a change to use the *page view* as the fundamental unit of measurement, rather than the number of hits to the web server.

When you are measuring page views, the obvious way to identify the page is by using the URL. Many analytics products record page URLs by default. [Google Analytics does this][ga], which means that the baseline implementation involves placing the library file on each page, but not any configuration on individual pages. It records a page view for each URL loaded in the browser's address bar.

 [ga]: http://www.google.com/support/googleanalytics/bin/answer.py?answer=66983#0.1.1_step4

Note that that page view ignores interactions that happen after the page has loaded (think AJAX). For this article, I am going to leave that on one side, and just consider the data that is known when the page is loaded.

## The URL is not enough ##

Unfortunately there are big problems with the exclusive use of URLs and page views:
 1. There is often a poor connection between URLs and 'pages' as imagined by a user on the site. There are many many reasons for this, perhaps the most pernicious being the inclusion of session data within the URL, so that each user sees a different URL for the same content. Fortunately, SEO concerns are increasingly forcing people to use good URLs.
 2. We need to see richer information about what is on the page. For example on an ecommerce site, we need to track shopping carts and purchases.

This means that we actually need to configure page-specific information, the *metadata*, on pretty much every page on the site.

On any big analytics installation, the metadata is likely to include [at the very least a page name][pn]: an identifier for the page which is more unique and descriptive than the URL. It will contain a category or hierarchy ID for sites where this makes sense. It will certainly [include ecommerce data][ecom] such as product SKUs, prices etc. on ecommerce sites.

 [pn]: http://www.webmetric.org/content/page_naming.php?jump_id=5678
 [ecom]: http://help.yahoo.com/l/us/yahoo/ywa/tracking/v5/ecomsite/ecomsite-01.html

Which brings us to the core of this article.

<div class="pullout warning">
  <p>If all you need is to record page URLs, then marking up pages is really simple.</p>
  <p>But if you need to configure specific data about each page, the cost and effort will greatly exceed the cost of just deploying the library file.</p>
</div>

This is why we at jsHub believe that the real problem to solve is getting everyone to agree a format for Universal Data, not just adopt a universal tag library file.

In the past, the products we use on the site split neatly into two groups. Web analytics requires the full panoply of deep data. Omniture SiteCatalyst for example offers 50 pathing and 50 ecommerce variables, plus a range of standard page related variables. The other consumers of data (for example, ad networks and email providers tracking responses to a campaign) really did not need anything so complex, and could just use the page URL.

## Same data, different apps ##

In the last few years, there has been an explosion of new products that need the full data, such as A/B testing, behavioral targeting, product recommendations. Because they need the rich view of the clickstream data, most or all of the variables defined for web analytics would have to be written into the page again, but in a different proprietary format. This is the biggest cost in deploying these applications.

The cost of updating all the pages to re-declare all the data is so prohibitively expensive that a big part of my job at Touch Clarity (a behavioral targeting solution) was to create custom code to do the mapping from one format to another. We built connectors to extract the metadata from all the major enterprise web analytics vendors, including Webtrends, Omniture and Coremetrics.

This was always a bespoke project, highly customized for each customer. Why? Here are some of the reasons:
 * Each client is using a different subset of the features provided by their analytics.
 * There is no standardization of the field names. For example a page name is `WT.pn` in Webtrends, and `s.pageName` in Omniture.
 * Even within a single product, there's no standard for some of the data. SiteCatalyst allows 50 numbered ecommerce variables. What does `s.eVar12` represent? There's no way to tell, except by looking at a spreadsheet which is maintained by the client and may or may not be kept up-to-date as the site evolves.

This is madness. And as the richness of the data improves and the number of apps that need it also increase, the problem is only going to get worse.

There are two ways out of the problem of redeclaring all the data. One is to build some kind of universal connector, which can read the existing data in whatever format it exists. The other is to define a standard format for metadata, and use this standard data to feed all the apps.

At jsHub we have built both: we have a [microformats-based metadata standard][hPage] and a [plugin architecture][arch] for the tag which allows vendors to create plugins that can read their proprietary markup.

 [hPage]: /projects/markup/
 [arch]: /projects/jshub/#plugin_architecture_and_extensibility

This gives a clear migration path for any site that wants to move from their existing proprietary format, to a new open format that can be used for any application.

In a future article, I will describe the design decisions we took in creating the new metadata standard. I'll also address what happens in a dynamic world, where AJAX, Flash and Silverlight mean that the page view is no longer enough.

