---
published: false
layout: post
categories: 
- performance
- architecture
comments: true

title: Back to Basics - defining a minimal tag
author: Fiann O'Hagan
--- 

The jsHub project offers a lot of good functionality to sites. We have an event based architecture, which enables you to deploy the [Tag Inspector][inspector]. We have a novel form of [markup for metadata][markup], based on HTML microformats. We have a [plugin architecture][tag], potentially allowing you to collect data in a variety of different forms, and to send it to various services.

 [inspector]: /projects/inspector/
 [markup]: /projects/markup/
 [tag]: /projects/jshub/

Perhaps less visible, we are very strict about all our code going through a robust testing process: [automated][auto], [continuous][CI], and [cross-browser][xbrowser]. New plugins are added to the [configurator][conf] (although this is not yet fully functional), and demonstrations of the code in action are added to the [demo store][store].

 [auto]: /projects/jshub/#robust_well_tested_open_source_code
 [CI]: /blog/2009/08/26/continuous_testing_with_runcoderun/
 [xbrowser]: http://litmusapp.com/
 [conf]: /configurator/
 [store]: /projects/demos/

All of this functionality requires code. In the world of page tagging, more code means one thing above all else: page weight. For most site owners, all page weight is not created equal.

Let's look at some figures about page weight.

<div class="pullout warning strong">
  <p>Want to get some numbers from John / Spidey, for top 1000 sites. Ideally we would be able to graph the raw numbers.</p>
  <ul><li>Distribution of page size, both HTML and total for all assets</li>
      <li>Number of tags</li>
      <li>Combined weight of tags</li>
      <li>Combined weight of tags as a fraction of total page weight</li>
  </ul>
</div>

I can see a few interesting facts from this **guesses to be updated!** 

 * Some sites have a lot of tags, but even so, the tags do not form a large proportion of the total weight of the page.
 * The majority of sites already have XXX kb of page tags

IT teams are responsible for both the performance the page, and for deploying the tag libraries. The load time of the page is (to a [first approximation][hpw]) proportional to the overall weight of the page. Most of the weight comes from content that's under the control of editorial teams, who are more conscious of impact than performance. 

 [hpw]: high performance websites

While the tags may be a small proportion of that overall weight, the IT team would like to minimize at least the portion of the page weight that they can control. That's the reason not all page weight is equal.

## A jsHub tag, but smaller ##

We can use this data to set some constraints on baseline functionality of the jsHub tag. Here are the things that really must be included for the code to count as jsHub:

 * The event dispatch architecture and plugin API. This is what allows plugins to communicate and is the "hub" in jsHub.
 * Basic technographic data capture. It's likely that every application will always need the ability to collect the page URL and referrer, and a few other core fields.

That's really all that is essential. With this, we would be able to provide the set of features that many sites are currently using. For example, this is enough to provide the core data for [Google Analytics][ga], [Yahoo Analytics][ya] and [Comscore Direct][cd]. [NB these are illustrations: there is not (yet) a plugin for any of these services publicly available]

 [ga]: http://www.google.com/analytics/
 [ya]: http://web.analytics.yahoo.com/
 [cd]: http://direct.comscore.com/

<div class="pullout note">
  <p>Our goal is to have the baseline tag <strong>below 10Kb in page weight</strong>. This would make it comparable with the libraries of the major free web analytics providers.</p>
</div>

The great thing is that we will be able to provide a library which matches the basic functionality of many of the major web analytics products, with the same page weight, but provide the benefits of the jsHub framework. Let's just highlight two of them. First, you can use the Tag Inspector. You get visibility of all the data you are collecting from a page, and you can get automatic warnings about some of the common implementation errors. Second, the tag is extensible; when you are ready to use another service, you can just add it in the configurator.

**How big is the tag right now?**

## Get More Free Stuff ##

Because the tag is plugin based, and therefore extensible, some of the functionality we currently consider to be core is going to move into plugins.

This allows you a clear upgrade path, as and when you feel that the benefits justify the additional page weight.

First, microformat markup. 

