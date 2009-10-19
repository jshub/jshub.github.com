---
published: true
layout: post
categories:
- universal tag
- markup
comments: true

title: What is a Universal Tag?
author: Fiann O'Hagan
---

<div class="pullout note">
  <p>This is my first post on the jsHub project, and I want to give some background for why we are building this technology. If you're already familiar with tagging, then this will probably be a bit basic.</p>
</div>

A lot of sites use products that rely on [clickstream data][1], to provide information about user behavior on the site. This data is used to power web analytics, product recommendations and A/B testing solutions. Similar but less detailed information is used to record click-throughs from emails and banner advertising.

 [1]: http://en.wikipedia.org/wiki/Clickstream

This information is recorded by a tag. The tag gets its name from the earliest incarnation, which was a single HTML `<img>` tag. Many ad beacons still look like this, but more commonly they are now chunks of JavaScript code. Using JavaScript allows them to collect more information and be more configurable.

The problem comes with the increasing number of services that need tags to run today's websites. John Graham-Cumming recently [posted about jsHub][2] and gave the example of [World Wrestling Entertainment][3], with 11 separate tags.

 [2]: http://www.jgc.org/blog/2009/10/what-is-jshub.html
 [3]: http://us.wwe.com/

This profusion of tags is a problem for the industry. It's wasteful, firstly because of the impact of all the code on the page weight. The user experience can be affected by the amount of additional code being downloaded. Secondly, it wastes IT time and resources placing all of these tags on the site. 

And finally, it's just plain ugly. It's a clear violation of the good software engineering practice of Don't Repeat Yourself, because the same data is being placed on the same page multiple times, to meet the needs of the different products in use.

## Enter the Universal Tag ##

So wouldn't it be great if we could rip out all those different tags, and use a single master tag to capture all the data you need?

This is the vision of the [Universal Tag][ut]. There's no generally accepted definition of the concept yet, but here is a quick list of the features that any self-respecting universal tag should include:

 [ut]: http://www.liesdamnedlies.com/2008/10/whence-the-universal-tag.html

 * It drives multiple products. Note that we're already stepping back from the word 'universal' here: it won't necessarily support *every* tag out there.
 * It gives you centralized control: there's a single, central location to add / remove tags, rather than touching all the pages or templates on your site.
 * It removes repetition: if there's special markup needed on a page, then it can be used for all the tags rather than repeated for each one.

A universal tag allows you to roll out a new tag library across your whole site in one go. This is a massive win for speeding up the deployment process. 

It's a new concept but one which is [starting to get a lot of attention][4].

 [4]: http://semphonic.blogs.com/semangel/2009/10/data-warehousing-analytics-data-and-the-universal-tag.html

Unfortunately, it's only half the story, because getting the library onto the pages is not the hardest part of the work. But that is the subject of another article.