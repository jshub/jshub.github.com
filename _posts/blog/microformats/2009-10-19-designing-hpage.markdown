--- 
published: true
layout: post
categories: 
- markup
- microformats
- design
comments: true

title: Designing hPage for data capture mark-up.
author: Liam Clancy
feature: hpage
---  

<div class="pullout note">
  <p>Blogs aren't just about what is happening now.</p>
  <p>We have made a lot of progress at jsHub.org and I'd like to share with you how we came to the designs and ideas we currently have, starting with...</p>
</div>

## Collecting data

One of the most critical requirements for any web based analytics product is the ability to **capture 'quality' data** from a client's website pages and the interaction of individual users when on them. 

Traditionally this is done by the clients IT team adding vendor specific JavaScript to every page, normally with the help of a consultant who will help map business and marketing concepts onto some sort of data structure to enable their product to produce <del>pretty</del> meaningful reports.
    
At [jsHub.org][jshub] we are attempting to provide a [vendor neutral format][hpage] for this metadata, and have a lot of interest from [established][ga] [vendors][wt] in the US and EU to validate this a desirable solution, 

We have an [introduction][hpage-intro] for those with existing analytics implementation knowledge but in this post I'd like to explain some of the technical reasons for using an HTML [microformat][mf] approach in the first place.

[mf]: http://microformats.org/about
[jshub]: https://jshub.org/
[hpage]: https://jshub.org/hPage/
[hpage-intro]: https://jshub.org/projects/markup/introduction.html
[ga]:  http://www.google.com/analytics/
[omtr]: http://www.omniture.com/
[wt]: http://www.webtrends.com/

## Why do we still use JavaScript?

It's always best to start with the obvious and this question has recently gained attention in [discussions][why-js] about developing a **Universal Tag**.

So, why do we use JavaScript as the data capture mark-up language?

Once upon a time the key information clients wanted was only available by running JavaScript in the users browser:

<pre class="brush: js; gutter: false;">
window.location.href // The page URL = a 'hit'
navigator.userAgent // The browser
document.referrer // Where the user came from
window.screen.width // Screen size, plug-ins, etc
</pre>

and a means to get this sent to the server was to dynamically create an `<img src="...` URL from this data so that these parameters would appear in the standard web server log files.

This was an improvement over static images ([web bugs][web-bug]) which you still see as the fail-over means of sending data in the `<noscript>` code and other environments where JavaScript is not supported, such as in email clients and most mobile phones of the pre-iPhone era.

We'll talk more about our **data transport** design in later posts.

However, for most professional web analytics usage this sort of passive data collection is not expressive enough, as we have detailed in [A URL is not enough][post-universal-data]

Almost immediately clients and vendor developers <del>hacked</del> needed means to set variables on a page and have these captured so that they could make sense of their own data.

These variables have never been standardised and now comprise the proprietary vendor mark-up that has to been added to **every single individual page** on a website.

Despite its growth I would be surprised if many [Google Analytics][ga] implementations actually use this [basic][trackPageView] feature (awaiting some research data to back this up).

[why-js]: http://vorpal.iwright.org/blog/2009/10/01/x-change-2009-universal-tag-huddle-summary/
[web-bug]: http://w2.eff.org/Privacy/Marketing/web_bug.html
[trackPageView]: http://code.google.com/apis/analytics/docs/gaJS/gaJSApiBasicConfiguration.html#_gat.GA_Tracker_._trackPageview
[post-universal-data]: /blog/2009/10/17/universal_tag_or_universal_data/

## Pro's and cons of JavaScript for data capture mark-up

So, we need a way to set variables and their values on a web page.

Choosing JavaScript for the data capture mark-up seems a good-enough solution since the vendor library is implemented in JavaScript, but Enterprise and other business websites are unfortunately a very different environment for a developer than that of an Open Source project, blogger or home-grown website. 

Its quite common for the website to be managed by many teams with differing priorities and levels of access to make changes in even the smallest areas, sometimes via a CMS interface.

Its also a common occurrence for marketing projects to create one-off **microsites** and other short-term but high trafficked areas that may be managed and hosted by external agencies.

As a result we identified a number of problems with using JavaScript that keep large website maintainers awake at night:

 1. _It's executable code!_
    This is the **No. 1 problem**. Any mistake in writing the mark-up in JavaScript has the potential to cause a visible error on the page, even something as trivial as using the wrong type of quote:
    
    <pre class="brush: js; gutter: false;">
    var myVariable = 'jshub's example'; 
    // this causes an error
    </pre>
        
    These errors can also cause the JavaScript interpreter to stop running for the rest of the page, and given the increasing reliance of websites on JavaScript functionality in general, such as AJAX updates, this is obviously a major cause for concern.
 1. _Mark-up is dependent on the JavaScript library being present._
    In most current vendor releases there is an assumption that the core functionality needed will be loaded in the page before the mark-up is declared:
    
    <pre class="brush: js; gutter: false;">
    pageTracker._trackPageview('Homepage'); 
    //assumes pageTracker is already declared and has a function called _trackPageview
    s.pageName = 'Homepage'; 
    //assumes that 's' is already declared
    cmCreateRegistrationTag('Homepage'); 
    // assumes function cmCreateRegistrationTag is already declared
    </pre>
    
    This makes it very hard to create, test and deploy pages with mark-up until the JavaScript library has been deployed across all the required servers where the page may be displayed.
    
    Since there is a load-order dependency in the web page there are  constraints on where exactly the mark-up can be output with potential implications on [page performance][page-perf] vs. [user experience][ux].
    
[page-perf]: http://www.stevesouders.com/blog/2009/04/27/loading-scripts-without-blocking/ 
[ux]: http://www.stevesouders.com/blog/2009/05/06/positioning-inline-scripts/
    
 1. _CMS templating of JavaScript is difficult._
    Most large websites do not trust their editors (for good reasons) and the use of Content Management Systems has been the adopted solution, allowing controlled publication of content on web pages without technical knowledge of HTML and other web technologies.
    
    Since the mark-up needs adding to every page, this needs to be part of the **publishing process** to avoid side-channels of information but allowing editors to enter any content requires [XSS][xss] security holes to be protected against.

    In addition it's logical to reuse some content as data mark-up but the output needs to be processed in subtly different ways to be used within HTML and JavaScript, for example these are equivalent:
    
    <pre class="brush: html; gutter: false;">
    <span>TV's &amp;amp; Radio</span>
    </pre>
    <pre class="brush: js; gutter: false;">        
    var pageName = 'TV\'s &amp; Radio';
    </pre>
        
    There is often a desire to use a CMS to ease deployment of the vendor JavaScript library, but it is the declaration of mark-up that provides the greater challenge for CMS integration teams.
    
    <div class="pullout warning strong">
    No-one really wants their CMS editors to have to hack their way past the UI interface just to provide data for their expensively purchased product do they?
    </div>
 1. _JavaScript mark-up cannot be validated._
    Notwithstanding a lack of standardisation across vendors, it is also very hard to determine whether data is being marked-up consistently or accurately across pages on the same website, leading to the need for supersets of metadata to manage very large scale and advanced implementations (expressed in JSON or other mappings), and programming teams can get very creative with these solutions.
     
    This is further complicated by the need for any automated web crawling tool to be capable of evaluating JavaScript code itself to determine the actual runtime data declared by the mark-up:
    
    <pre class="brush: js; gutter: false;">        
    var pageName = 'Home'+'page'; 
    // data evaluated at runtime as 'Homepage'
    </pre>
       
    Finally the users who are really need and are able to validate the mark-up are the content creators and marketing team, many of whom do not know any JavaScript at all.

These are the main problems, and there are no technical benefits to declaring mark-up in JavaScript that out-weigh them.

[xss]: http://en.wikipedia.org/wiki/Cross-site_scripting

## Designing a new solution to data capture mark-up

So, what we needed was a practical solution that takes into account the above problems with JavaScript mark-up and the ways in which Enterprise web sites are managed and maintained.

It wouldn't hurt if we also got some other benefits out of the solution too.

Actually we don't need a **new** solution since the HTML specification includes `<meta />` [tags][meta-tag] for document level metadata, which can be used for generic data mark-up, but these fell out of favour when used to abuse Search Engines rankings.

Revisiting the `<meta />` tag we determined that, in general declaring data in HTML addresses the above issues as:

 1. _HTML is not executable code._
    In addition HTML parsers in web browsers are now very mature with a long history of being designed specifically to handle common author errors and invalid declarations of HTML tags, and deal sensibly with them.
 1. _Data mark-up in HTML has no dependency on JavaScript._
    The HTML can be speculatively added to a page when published in anticipation of being captured and used by vendor product some time in the future.
    
    The data can also be marked-up anywhere HTML is supported but JavaScript is not, for capture and transport by other means. For example the HTML content may appear in a WebKit view in a native iPhone app or the HTML help in a desktop application.
 1. _CMS are designed to output HTML._
    These too are mature at providing the means for editors and content creators to easily enter or reuse the data as part of their publishing processes.
    
    Once encompassed by a CMS the data itself can also be used more effectively as content is manipulated and transformed over its lifetime.
 1. _HTML can be validated and indexed by design._
    This has enormous benefits for the usefulness of declaring metadata in the first place. 
    
    Not only is HTML based data machine readable for validating against shared schema (once created) but by using existing tools and best practices it can be indexed by search engines and other web crawlers to ensure the data is present everywhere a vendor product requires it.
    

We also get a number of additional benefits, both from the choice of HTML itself and the way in which it could be implemented for our users.

Some of these are:

 1. _The browser tells us when the HTML is ready_.
    Since in most browsers can fire a `domReady` type event we can now be assured that we are reading the data at the earliest possible time **when all the data is available**, and not dependent on where in the page the data is marked-up.
    
    <div class="pullout code">
      <em>domReady</em>: Fired on a Window object when a document's DOM content is finished loading, but unlike "load", does not wait until all images are loaded.
    </div>

    Moving to an **event driven** architecture for the core jsHub library was also a key design decision.
 1. _Removing inline scripts increases page performance_.
    Who [knew][ss-inline]? But we do now, and shouldn't ignore it.

[ss-inline]: http://www.stevesouders.com/blog/2009/05/06/positioning-inline-scripts/

All these benefits come from using any HTML for the data mark-up, but unfortunately the `<meta />` tag is not entirely suitable since it can only appear in one place: the `<head />` of a web page (an area generally inaccessible to the content creator when using a CMS) and there is also little provision for establishing any sort of structure for the data itself.

I initially started looking at structuring data using hidden `<form />` tags, but once I (re-)discovered the [Microformats.org][mf] community I realised that they had already been addressing the use of HTML for expressing data structures and that they had also outlined ways to encourage the adoption and implementation of the microformats developed, giving us the requirements to create tools such as the [Inspector][inspector].

To my knowledge no-one had currently assessed web analytics data capture mark-up as a candidate use case for a microformat, and once we undertook to follow the [microformats process][mf-process] ourselves [hPage][hpage] was born.

[meta-tag]: http://www.w3.org/TR/REC-html40/struct/global.html#h-7.4.4
[inspector]: /projects/inspector/
[mf-process]: http://microformats.org/wiki/process

## The future

Using a microformat is not the only way to do data mark-up with jsHub, either now or in the future, but we think its currently the best way. We are keeping abreast of [developments][html5-data] in [HTML5][html5] with this in mind.

<div class="pullout info">
If you are creating web pages on a website, with or without a CMS, think ahead to how you will measure the success of those pages one day and why not implement hPage, just in case?
</div>

[html5]: http://dev.w3.org/html5/spec/Overview.html
[html5-data]: http://dev.w3.org/html5/spec/Overview.html#custom-data-attribute