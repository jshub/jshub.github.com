---
layout: static
title: Microformats Introduction 
---


# Microformats for markup standards #

jsHub.org is sponsoring several independent projects.

The main project is a specification for marking up metadata about pages viewed by users and other data required to measure content exposure and interaction behavior of web users. 

The specification has been drafted as an **html microformat** as there are a number of advantages with this approach for website owners and it lends itself well to vendor collaboration.
 
The following sections supplement the actual [hPage specification](/hPage) by providing information about the microformat approach for those who may be more familiar with traditional JavaScript based methods for markup.


##Microformats and page markup ##

The simplest way to collect user interaction data from websites is simply to record the URL of each page that is being viewed by the user. This is commonly achieved with a 'web beacon' or single pixel image placed on the page. When the browser requests the image from the server, the URL of the image is recorded, and the URL of the page that the image is embedded in is also recorded, inferred from the HTTP referrer field sent in the request. 

For web analytics and other purposes, the URL of the page alone often does not provide sufficiently rich information to deliver the service. Therefore most web analytics products allow page authors to place additional information in the page markup to be collected by the web analytics tag. In most cases this is configured using JavaScript markup.

jsHub proposes using HTML rather than JavaScript for marking up the metadata of the page. There are several advantages to this approach, because it makes the metadata about the page part of the document itself, rather than a side channel. Firstly, this means that it is easier to provide tools to visualize the data, and so it is more likely to remain up to date and complete than if it is not visible and accessible to the page author. Secondly, placing the data in the page structure makes it available to search engines and other automated tools indexing the pages, and therefore allows potential benefits in search engine visibility (SEO). Thirdly, placing the data in the page reduces duplication between page data and data in a side channel, which reduces the scope for conflicting data.

## Comparison with existing page metadata structures ##
Existing metadata about web pages can be found in three places. The most widely deployed is JavaScript in the page. The other main approaches are to place external XML data files, and to use `<meta>` tag elements within the HTML.

### JavaScript metadata ###
Most web analytics products use JavaScript for marking up the metadata they require. 

For example, Google Analytics uses the approach of passing parameters to a function call, as per the [documentation](http://www.google.com/support/googleanalytics/bin/answer.py?answer=55528&topic=11002): 

{% highlight js %}
pageTracker._trackPageview();

pageTracker._addTrans(
  "1234",                                     // Order ID
  "Mountain View",                            // Affiliation
  "11.99",                                    // Total
  "1.29",                                     // Tax
  "5",                                        // Shipping
  "San Jose",                                 // City
  "California",                               // State
  "USA"                                       // Country
);

pageTracker._addItem(
  "1234",                                     // Order ID
  "DD44",                                     // SKU
  "T-Shirt",                                  // Product Name 
  "Green Medium",                             // Category
  "11.99",                                    // Price
  "1"                                         // Quantity
);

pageTracker._trackTrans();
{% endhighlight %}

Omniture wrap this by defining a global object `s` and setting named properties on that object. 

For example, here is the metadata from Omniture's [homepage](http://www.omniture.com/en/):

{% highlight js %}
/* PAGE SPECIFIC */
s.pageName='Omniture: Homepage';
s.channel='Home';
s.prop6='English';
{% endhighlight %}

Coremetrics also utilize the function parameters approach, for example as implemented on the [Bank of America homepage](https://www.bankofamerica.com/index.jsp):

{% highlight js %}
cmCreateRegistrationTag(null, 
  'ngen-personal', 
  '20090429:0:E:16CB099F-1520-01f4-00000000BFA6871D', 
  false, 
  null,
  null,
  'homepage');
{% endhighlight %}

The last parameter to this function call is equivalent to the Omniture SiteCatalyst variable `s.pageName` in the previous example. 

WebTrends recommends the use of HTML `<meta>` tags but allow JavaScript variables to be used as well. They recommend this HTML:

{% highlight html %}
<META NAME="WT.pn" CONTENT="Homepage"> 
{% endhighlight %}

but this JavaScript is equivalent:

{% highlight js %}
WT.pn = "Homepage";
{% endhighlight %}


#### Pros and cons ####
The JavaScript approach is convenient for the vendor, because it makes all the data immediately available and it facilitates some preprocessing before the data is submitted to the server. However it is not so convenient for the webmaster responsible for maintaining the page.

Each product that uses a JavaScript tag has its own markup syntax, and although there is a lot of overlap in the data collected, each product requires it in a different format. This imposes a learning curve on the implementor, and an overhead where a site has multiple tag-based products deployed on the same pages. For example, a site may have a combination of web analytics, on site search, product recommendations, A/B testing and email tracking implemented at the same time. This means a duplication of data.

Any scripting approach also has inherent problems because the configuration is in program code. This is fragile, as any error can prevent data capture working on that page and possibly break other features of the page. For anyone other than professional developers, it is difficult to author and difficult to debug. In practice, this often means that in larger organizations, the metadata is not maintained by the person editing content on the pages, but instead is a completely separate responsibility. 

On larger sites, the scripts may grow in complexity organically. The enterprise can end up with a large script, where sections are redundant but no-one is confident about what can be removed without risking breaking the tracking. This only gets worse when a specialist moves on from maintaining the scripts.

Because the data is not easy to visualize or test, it can drift out of synch with the content of the page, and this is difficult to spot and fix. This has led to a demand for third party tools to assist with the usability issues in the configuration code, such as [WASP](http://webanalyticssolutionprofiler.com/).

### XML data and side channels ###
The Semantic Web project attempts to publish information about the page (rather than about the event of a user viewing the page), so that computers can gain deeper understanding of the material being published.

The main standard for publishing this information is RDF, which is an XML syntax for publishing assertions about relations between things in the world. For example, the FOAF (Friend of a Friend) spec allows authors to publish a machine readable version of the 'blogroll' on their site, giving links to other blogs that they consider worth reading. There are some other well-known sets of assertions giving real world relations, in particular the Dublin Core assertions, used in this example from [the W3C RDF primer](http://www.w3.org/TR/rdf-primer):

{% highlight xml %}
<?xml version="1.0"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
         xmlns:dc="http://purl.org/dc/elements/1.1/"
         xmlns:exterms="http://www.example.org/terms/">
  <rdf:Description rdf:about="http://www.example.org/index.html">
    <exterms:creation-date>August 16, 1999</exterms:creation-date>
    <dc:language>en</dc:language>
    <dc:creator rdf:resource="http://www.example.org/staffid/85740"/>
  </rdf:Description>
</rdf:RDF>
{% endhighlight %}

A challenge with RDF is that it can be a complex and unforgiving XML format, typically involving multiple namespaces and a lot of URIs. This means that while it is machine readable, the human readability can be poor, and for any non-developer it can be difficult to author manually. Currently there are few good tools for either reading or writing this information in common, mass market, use.

Because the XML is published as a separate file on the server, it forms a side channel that is not easily visible to page authors working on the site. So there is little incentive to keep it up to date and accurate as the site evolves. As with any process which requires the 'same' information to be published in two different ways in different locations, there is always a risk the two representations will drift apart.

The RDFa project addresses some of these issues by placing RDF data inline within the html of the page. This is a significant improvement because it puts the markup in the line of sight of authors. This specification is starting to gain some real world usage.

The microformat approach has many similarities to RDFa, but it emphasises reducing barriers to entry by using simple, pure HTML, approaches to markup. RDFa emphasises accurate and comparable data, while accepting a cost in the greater complexity of XML namespaces and URIs. 

The approaches are highly complementary, and we hope that both RDFa and microformats will continue to improve the machine readability of data on websites.

### HTML meta tags ###
WebTrends utilizes two forms of markup. It's possible to register data using the JavaScript variables approach but also using HTML `<meta>` tags, as in this example from [WebTrends' solutions page](http://www.webtrends.com/solutions.aspx):

{% highlight html %}
<meta name="WT.cg_n" content="Solutions">
<meta name="WT.pi" content="Solutions">
{% endhighlight %}

Meta tags share many of the advantages of microformats in terms of being simple to edit, readily available to html authors, and with low risk of errors causing major issues with the page. Although they are in the page, they can sometimes form effectively a side channel because they are not part of the visible content of the page.
 
Because meta tags have no hierarchy, they are not structured data. WebTrends successfully address this by namespacing some of the meta tag variables, but this introduces a cost of vendor-proprietary data in the html. Without the ability to structure the data, there are some limits to what the metadata can express.

The other major problem with meta tags is that carry a legacy of poor maintenance and keyword stuffing for search engine rankings. So they are typically treated as template boilerplate by many content management systems.

## The microformat approach ##
The jsHub project believes that it is time for a change in the way that metadata is published for web analytics and for other applications that need to know about the page.

The microformats approach is a big improvement over metadata presented in JavaScript code. The metadata is placed on the page in simple HTML structures, with particular values of the HTML `class` attribute used to indicate where the metadata is located. This means that a single language and structure is used for both the page content and the page metadata, and so any author who is reasonably comfortable with HTML can generate (and validate) the markup. 

### Microformats are human readable ###
Microformats are designed to be read by humans first and machines second. Any author who has used HTML will be able to scan a microformat and get some understanding of the data conveyed. 

{% highlight html %}
<div class="hpage">
  <ul>
    <li class="name">Microformat examples</li>
    <li class="title">Microformat blog: Microformat examples</li>
    <li class="type">Article</li>
  </ul>
</div>
{% endhighlight %}

Contrast this with the JavaScript approach where the data is held within code. 

The JS approach requires many people who consider themselves to be non-technical to learn complex and vendor-specific proprietary syntax in order to instrument their pages for analytics. This often leads to errors caused by cut-and-paste without understanding what is contained in the code. In larger organisations, it means that the metadata must be maintained someone other than the page author, increasing the chances for errors.

### Microformats are machine readable ###
All authors, even technical experts, benefit from tools to help with the creation of structured data. Microformat markup has a big advantage over JavaScript based markup, which is that it can be read quite simply by machines. This allows the creation of tools which can edit and use existing metadata on the page.

Many CMS systems allow the creation of JS metadata for selected web analytics tools and other applications, with varying amounts of manual coding required. However the format of the output is opaque, and in most cases the tools do not have the ability to read back the code and make changes. This is because the code needs to be executed to be sure of the effects. 

So the metadata creation tools end up being 'write only', once the configuration has been touched by a human editor then it is no longer possible to use the tool to edit it. In contrast microformats are pure html, and can be edited by any html authoring tools. 

### Microformats are robust to implementation errors ###
A related advantage of HTML is that the browser's HTML parser is much more flexible and forgiving than the JS parser. This means that HTML based markup is inherently more human-friendly to edit as well as to read. Non-expert users can edit the metadata and a mismatched closing tag will not break the page, whereas a misplaced closing bracket will almost certainly break a JavaScript.

### No side channels ###
Placing the metadata inside the content of the page brings it into the author's line of sight. JavaScript, html meta tags, and RDF or other external XML files all share the characteristic that they can only be seen when the author is specifically looking at them. Therefore they inherently cause an extra step in the editing workflow. All too often this is a step that can be omitted.

The microformat brings as much of the metadata as possible inline into the page. Not all the data will form part of the visible page, and the jsHub tag project provides tools to help visualise this data.

### Impacts on SEO ###
Placing the metadata into the page has a further big advantage that it makes it possible for applications other than browsers to parse it and extract information. In particular search engines may use the page metadata to improve and annotate their results. This is starting to happen with other microformats, for example Google have [recently announced support](http://google.com/support/webmasters/bin/answer.py?hl=en&answer=99170) for various microformats in their search results. 

Yahoo! have been major supporters of microformats, and their [SearchMonkey tool](http://developer.yahoo.com/searchmonkey/) makes extensive use of microformat data to enhance search results.

We recognize that there may be some temptation for webmasters to attempt to game the data conveyed in the microformats, if it turns out to have an impact on search engine rankings. However we do not anticipate the same level of problems and abuse that happened with html meta tags. 

Meta tag spamming was always essentially zero-cost because the data is not visible and has no other purposes, so deliberately using misleading data did not have any adverse impacts. Placing spam in hPage markup is not zero cost because the same data that is scraped by search engines, is also used to build reports which are essential for maintaining the site.

### An open specification ###
The microformat recommendation is an open specification. There is no requirement to use the jsHub tag, anyone is free to create their own parser for this data.

By making the data available once for all applications that require it on their site, webmasters are freed from duplication errors and the overhead of deploying and maintaining a new metadata format for each application.  

### So why has this not been used before? ###
We believe the single biggest reason for using JavaScript and not HTML for metadata about the page is historic. It has its roots in the capabilities of the generation of web browsers in common use at the time when the web analytics products were beginning to emerge.

The earliest analytics products used an inline html `img` tag to record the page view, and this was then generated by JavaScript and augmented with additional information available in script, such as the page title and referrer.

Early (version 4) browsers had very poor support for the Document Object Model, and this made it hard to traverse the DOM to extract structured data. There was, and still is, considerable difference between the methods used by browsers to retrieve the data. In contrast the implementation of JavaScript in the browsers (at least the parts required for capturing data from JS variables), and so placing metadata here was a path of much lower resistance.

The differences between browsers have basically been solved by standardization of the DOM methods, and by the creation of open source libraries which provide a higher level, browser neutral, language for addressing the DOM. The reference implementation of the microformat parser in the jsHub tag uses jQuery as the cross browser addressing layer.

It has recently become possible for the first time to extract microformat data from pages efficiently using JavaScript, and so it is the right time to start using a more semantic approach to page markup. 

In the longer term, we expect that website authors will consider marking up pages for web analytics to be an integral part of building a professional site, just as search engine optimization is an essential step. 

## Summary ##

jsHub.org is proposing a specification for marking up metadata about pages viewed by users and other data required to measure content exposure and interaction behavior of web users. 

This specification has been drafted using HTML microformats as it helps address a number of practical implementation challenges that have tended to occur with other methods.

