---
published: false
layout: post
categories: 
- partners
- configurator
comments: true

title: Multi-vendor code and multi-vendor hosting
author: Fiann O'Hagan
--- 

Right now, we are faced with a quandary.

Here's the situation: jsHub is a framework for a universal tag, which allows multiple vendors to supply plugins that can talk to their products. Most of those plugins will need some configuration (for example, a URL to send data to). A complete tag is a bundle of multiple plugins, from multiple suppliers, with a bit of custom configuration in each one.

Many of the vendors would like to present a front end so that their clients can configure a tag. You can see a work-in-progress view of our [configuration tool][conf] to get the idea. So that the client can create a tag with all the functionality they need, each of these vendors necessarily needs to present all available plugins, from all vendors, in this interface. 

 [conf]: /configurator/

Now here is the problem: Vendor A hosts the interface on their site. Vendor B makes a update to their plugin, which they want customers to be able to upgrade to. Or perhaps a new Vendor C joins the project and wants to make their new plugin available. Because Vendor A is hosting the configuration tool, the other vendors are reliant on vendor A keeping the code it produces up-to-date. Not just their own code, but all the code from all the vendors, who will likely have completely different release cycles.

## Wait, my tag is dependent on my competitor's website?

While several vendors have expressed a lot of interest in using jsHub technology, none of them will want to become dependent on a third party vendor's SLA and procedures.

We've been discussing this down at jsHub Central, and we struggled even to think of a comparable problem domain to draw inspiration from. Perhaps the closest example is a software aggregator such as the Linux distributions. They assemble a bunch of software tools, many of which will come from third parties. However, the next step is to certify (to some approximation) that this set of tools of specified version numbers all work together, and then distribute it from a central location.

They do two things very differently from our constraints. First the aggregator releases on its own timeframe, more or less independent of the release process for new code from the different suppliers. Secondly, there's an official distribution from a central location. They don't need to allow each of the teams who supply code to the project to roll their own distributions.

It looks like we need a new distribution process as well as a new tag. Here is our current thinking on three ways that this new process might work.
 1. A centrally hosted front end
 2. A distributed front end, talking to a central back end
 3. A federated distribution process

I'll discuss each of these options in turn.

## Option 1: centrally hosted front end

The simplest option is the closest to the model of the software aggregators. The code for every published plugin would be hosted on [jshub.org][/].

 [/]: /

When a partner wants to make a new plugin available, we will run it through our suite of testing tools (we don't interfere with functionality, but we do test all plugins for compliance with the API and some basic security checks). It then becomes available on the site.

The user comes in and chooses the plugins for their particular requirements. They configure each plugin as needed. We store the configuration in the database so that the user can update it later. Then the tag goes through our packaging process: the core hub code and the selected plugins are concatenated together, with configured values in place in the code; the debugging and lifecycle logging is stripped out; code comments are stripped out; and finally the code is compressed and minimized.

The advantage to this is there is a central clearing house for the code, and a single authoritative location from which to download a certified tag. Users from any of the participating vendors will have a profile in a central location, independent of any one of their suppliers.

The potential downside is that the vendors are ceding some control over the user experience to the jsHub project. We would certainly be happy to look at co-branding or even white labeling the experience, CMS-style, and there are plenty of good examples out there of this working. But still, the vendor doesn't have the same control that would be possible if they build and host their own user interface.

Secondly, the vendors are introducing a new dependency on jshub.org uptime and performance as part of their offering to their clients. Again, this is manageable but requires some thought.

## Option 2: central back end

The second option is to produce a hybrid approach. The user interface is controlled and hosted by vendors who choose to do so. I would picture this as being a template application which we would create and pass to the vendors for customization.

The front end application would speak to a centrally-hosted back end via an API, mash-up style. So the latest approved version of the code from each vendor would be available, with the correct configuration options, because the underlying source would be the central database.

The obvious advantage of this is that it puts more control over the experience in the hands of the vendor. Personally, I am very much in two minds about this. Suppose someone wants to use jsHub tags to drive product A and product B. Does it make sense for the configuration to be branded with product A? That said, one of the guiding principles of jsHub is that we don't want to muscle in between any of our partners and their customers. 

The downside is that it adds complexity and adds more work for partners that want to host the configuration tool. There would have to be a release process and update cycle for the tool itself, and so there is a maintenance overhead.

The other potential problem is of security. All the jsHub code is BSD-licensed, and anyone can reuse it however they see fit. However, if I was a customer downloading code to run on my site, I would definitely want to receive it from a location that I could trust. In this case, both jshub.org and the well-known vendors would count. But if we increase the number of locations where code can be downloaded, it does make it easier to imagine phishing-style sites springing up, offering tampered code for download.

## Option 3: federated distribution

The final option we can see right now is of federated distribution. Each vendor would have the option to configure and host their portion of the code on their own servers or CDN. Potentially each vendor would host the configuration screen for their code, and then redirect back to a central list when that step is complete.

This would mean a change from the packaging process I described above. Rather than concatenating all the plugins into a single library file, they would be distributed in a number of files hosted by their respective suppliers. The core library would act as a loader, bringing in the files from their different origins.

This would give the vendors the highest level of control over their development and release process, and over the user experience of configuring each of the plugins. 

There is a performance impact likely here which we would need to assess. For small JavaScript files, the overhead of opening a new connection and making the request exceeds any benefit of allowing parallel downloads, and so it's more efficient to bundle them into a single file. But we would need to quantify the real-world impact of this and decide whether acceptable performance can be met. Because of the way JavaScript execution "stops the world", it means that any one vendor's servers responding slowly affects all the other vendors' plugins running on time. 

It also closes the door to some security optimizations we would hope to make in the future. It's not possible for example to use closure scope for restricting access to some of the fields in code, when the code is in multiple files.

## And the winner is ...

Right now, this is a very open question. We would be happy to work towards any of these solutions.

My own opinion is that, on balance, the first option is the simplest and most preferable. As I have suggested above, we'd be happy to co-brand parts of the configuration tool, but I am not sure that any one vendor should have control of the overall experience. The user is not configuring a single product, they are potentially configuring a suite of products within the same workflow.

But jsHub is an open process, and this is only one opinion. 

Does anyone have any examples of projects that face a similar question? How are they resolving it? Are there other options we have not considered yet? 

It would be great to hear any suggestions, either as comments on this post or via the [mailing list][list].

 [list]: http://groups.google.com/group/jshub/