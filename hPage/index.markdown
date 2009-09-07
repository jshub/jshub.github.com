---
layout: home
title: hPage microformat specification
---

<p class="path noprint">
  <a class="pathentry" href="/">Home</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/hPage/">hPage microformat</a> 
  <br style="clear: both" />
</p>

{% include wiki_toc.markdown %}

# hPage Microformat #

**Status**
: Draft Specification

**Version**
: 0\. 1

**Editor/Author**
: Liam Clancy, jsHub.org   
   Fiann O'Hagan, jsHub.org 

**Copyright**
: The authors release all of their contributions to the public domain. This specification is released into the public domain.   
**Public Domain Contribution Requirement.** Since the author(s) released this work into the public domain, in order to maintain this work's public domain status, all contributors to this specification agree to release their contributions to this page to the public domain as well. Unreleased contributions may be reverted / removed.

**Patents**
: This specification is subject to a royalty free patent policy, e.g. per the [W3C Patent Policy](http://www.w3.org/Consortium/Patent-Policy-20040205/), and IETF [RFC3667](http://www.ietf.org/rfc/rfc3667.txt), [RFC3668](http://www.ietf.org/rfc/rfc3668.txt).

*This document represents a draft microformat specification. The current version is for discussion only, and nothing in this draft should be considered to be fixed.*

The key words *"must"*, *"must not"*, *"required"*, *"shall"*, *"shall not"*, *"should"*, *"should not"*, *"recommended"*, *"may"*, and *"optional"* in this document are to be interpreted as described in [RFC 2119](http://microformats.org/wiki/rfc-2119).


## Introduction ##
hPage is a microformat for defining the semantic properties of a web page at a certain point in time, primarily but not exclusively in combination with recording a user's clickstream and other events generated while navigating a website. Although it is inspired by the needs of web analytics, the specification is intended to provide data for many solutions related to measurement and optimization of a customer's experience. 

hPage seeks to reintroduce functionality lost by the abuse of HTML `meta` tags and is influenced by existing best practices in the SEO and web analytics vendors. 

The hPage specification addresses three issues in the capture of clickstream data:
 1. It provides a standard mechanism for declaring metadata about the page.
 2. It provides a mechanism to indicate that a single HTML document may contain more than one visible page of content (e.g. because of AJAX content loaded after the page has loaded).
 3. It provides a way to record what dynamic content was displayed within each view. 

The specification improves the accuracy of page views as a metric of engagement by recording the actual content that the user has seen, including AJAX content and dynamically served components of pages. The concept of hidden content allows authors to record content which is seen only after the page has loaded.

hPage content is easily added to web pages and applications by simple modifications to existing HTML code and replaces similar declarations of data in JavaScript code while retaining backwards compatibility.

## Scope ##
The hPage specification provides a format for metadata about the page, including details of dynamic content that appears on the page. 

The specification does not address other user interactions with the site, such as ecommerce, user authentication, and interactions with rich media and video.  

## Schema ##

### Hierarchy of concepts ###
An HTML document is composed of one or more visible *pages of content*. 

Each page of content is described by a single *hPage*. 

Each hPage may contain zero or more *dynamic content fragments*, which can change with each page view, in addition to the static content which is always served at that URL.  

Additionally, each hPage may be defined by data from more than one node of the document, according to the data declaration rules.

### Case sensitivity ###
All keywords and references are case-sensitive in the relevant specs but treated as [case-insensitive](http://tantek.com/log/2002/12.html#atoc_csensitivity) in browsers and so *must* be made lowercase to avoid unexpected behaviour.

### Root class name ###
The root class name for an hPage is `hpage`. An element with a class name of `hpage` is itself called an hPage node. 

### Property and sub-property list ###
The properties of an hPage are represented by elements inside the hPage node. Elements with class names of the listed properties represent the values of those properties. Some properties have sub-properties, and those are represented by elements inside the elements for properties.

The property class names may be applied to any HTML element, but follow the [Semantic XHTML Design Principles](http://microformats.org/wiki/semantic-xhtml-design-principles).

**`hpage`** *required*
: Class name for the root html element which wraps all hPage properties.
  
**`version`** *optional, singular*
: Specify a particular version of hPage that their content uses. By omitting this field, the publisher is stating that implementations may interpret the hPage according to any version of the hPage specification. 

**`name`** *required, singular*
: The page name. 

**`title`** *optional, singular*
: The page title. If not present, parsers may assume an implicit value from `document.title` in a web browser.

**`referrer`** *optional, singular*
: The URL of the referring page. If not present, parsers may assume an implied technographic value from `document.referrer` in a web browser.

**`type`** *optional, multiple*
: The page type. Where one of the standard enumerated values is applicable, it should be used, as this will allow consumers of the microformat data to make inferences about user behaviour, e.g. `Homepage|Landing Page|Product|Review|Funnel|Checkout|Login|Logout|etc`

**`category`** *optional, multiple*
: Text keywords or phrases, or using rel-tag (see below).

**`lifetime`** *optional, singular*
: Duration or end date using the [Datetime design pattern](http://microformats.org/wiki/datetime-design-pattern). This may also be inferred from the Expires HTTP header, if the parser has access to the headers.

**`hidden-on-load`** *optional, singular*
: Boolean. If this is set to *true* it indicates that this hPage instance describes content that is not visible when the page is loaded, and so the data should be ignored when the page is initially parsed. 

**`content`** *optional, multiple*
: Reflects a content fragment shown on the page, so that parsers can be aware of the content shown on a dynamically-assembled page.
: **`id`** *required, singular*: A unique ID for the content item, with no defined format. The same content shown on different pages, should be given the same ID.  
: **`group`** *optional, singular*: A unique ID for a logical group of content. This could be the proposition, campaign, the theme in an A/B test, or any other category of the content. Content which is substantially the same, but presented in a different format, should have the same group ID.  
: **`slot`** *optional, singular*: A unique ID for the placement on the page, with no defined format. Reflects the location where the content was displayed, so that recipients may compare the effectiveness of the same content at different locations on the page.  

**`attribute`** *optional, multiple*
: Allows the author to specify additional attributes of the page which do not fit into the properties defined in this specification. The value class pattern is used to extract values.
: **`type`** *required*: The name of the attribute.
: **`value`** *optional*: text, Boolean or implied value of true if not specified.

**`author`** *optional, multiple*
: The page author, defined using an [included hCard reference](http://microformats.org/wiki/include), as used by hReview and other microformats.

### Examples ###
The smallest hPage that is valid contains only one required field, the page name:
<pre class="brush: html;">
    <div class="hpage">
      <span class="name">Homepage</span>
    </div>
</pre>

Note that the class names *hpage* and *name* may be applied to any (valid and semantically correct) html elements, for example `div`, `span` or `p`.

A more complete example would be:
<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">Microformat examples</li>
        <li class="title">Microformat blog: Microformat examples</li>
        <li class="type">Article</li>
        <li class="category">microformat spec web html</li>
      </ul>
    </div>
</pre>


## Design Principles ##
This microformat utilises the Microformats.org [key principles](http://microformats.org/wiki/principles), summarized here:
 * Solve a specific problem
 * Design for humans first, machines second.
 * Reuse existing building blocks, such as semantic HTML and existing microformats
 * Modularity / embeddability
 * Enable and encourage decentralized and distributed development, content, services. 

### hPage metadata may be hidden ###
We make one amendment to these principles, which is to state that hidden metadata is acceptable. The general principle is that "*visible data* is much better for humans than *invisible metadata*". 

Where the data forms part of the content that the author wishes to show to the user, then it should be displayed. 
<pre class="brush: html;">
    <div class="hpage">
      <span class="name" style="display: none">hPage Specification</span>
    </div>
</pre>

<pre class="brush: html;">
    <div class="hpage">
      <h1 class="name">hPage Specification</h1>
    </div>
</pre>

These examples are equivalent, but the second form is preferred because the data is visible (it forms the page heading), and so more likely to be well maintained.

However, not all of the data defined in this spec will naturally form part of the visible page shown to the user. Page authors may freely use CSS to conceal this metadata. It is intended to provide tools to make all metadata easily visible to content creators, which will reduce the impact of hidden metadata.

Hidden metadata is independent of the `hidden-on-load` property, which is used to mark page content that is not visible when the page loads.

### hPage may be declared in multiple locations ###
We also make one significant addition to the design principles. We introduce the concept that a single (logical) hPage may be declared in more than one location on the page. If all the content on a web page is visible to the user when the page loads, then the page is logically represented by a single page view and hence a single hPage instance. 

This single hPage instance per page of content is composed by the parser from all the hPage data on the page using the declaration rules. 

It does not follow that there is a one-to-one correlation between an hPage and an HTML document. In many cases, a single HTML document may contain more than one page of content.

## Declaration of hPage data ##
There are cases where the page author is constrained by the underlying technology producing the HTML document, and it is simpler to split the information for the hPage into separate elements. For example, the content management system produces the page name from one template component, and the page categories (social tags) from a separate component. This can make it difficult or impossible to co-locate the data in a single location in the generated page.

In this case, the page may contain multiple instances of hPage. Parsers *must* treat these as if they are a single hPage declaration, combining the properties from each hPage into a single output, and applying precedence rules to remove duplication. 

### Composition ###
This simple hPage:
<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">Microformat examples</li>
        <li class="title">Microformat blog: Microformat examples</li>
        <li class="category">microformat spec web html</li>
      </ul>
    </div>
</pre>

may equally be represented in multiple hPage declarations. For example, it may be simpler to construct the hPage in two separate regions, if the category data is held in a separate component on the server. 

This representation is equivalent to the previous one, because there is no conflict in the data between the declarations:

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">Microformat examples</li>
        <li class="title">Microformat blog: Microformat examples</li>
      </ul>
    </div>

    ... more text ...

    <div class="hpage">
      <ul>
        <li class="category">microformat spec web html</li>
      </ul>
    </div>
</pre>

### Overriding of singular values ###
Where a property takes a *singular* value, such as the page name, then later values overwrite the previous declaration. This code is also equivalent to the previous example:

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">Initial page name, will be overwritten</li>
        <li class="title">Microformat blog: Microformat examples</li>
      </ul>
    </div>

    ... more text ...

    <div class="hpage">
      <ul>
        <li class="name">Microformat examples</li>
        <li class="category">microformat spec web html</li>
      </ul>
    </div>
</pre>

### Additivity of multiple values ###
For properties that take multiple values, then later values are appended to the previous values, so the following is also equivalent to all the previous examples in this section:

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">Microformat examples</li>
        <li class="title">Microformat blog: Microformat examples</li>
        <li class="category">microformat spec</li>
      </ul>
    </div>

    ... more text ...

    <div class="hpage">
      <ul>
        <li class="category">web html</li>
      </ul>
    </div>
</pre>

## Multiple pages of content in a single HTML document ##
Some documents may include more than one *page of content*, where not all of the content in the document is visible to the user when the page is first loaded. A common example is a tabbed page layout, where much of the content is hidden until a navigation element is clicked. This produces an effect similar to navigating between separate HTML documents in an HTML frames layout.

<div markdown="1" class="caption">
![Tabbed content](/images/hpage/tabbed_content.png)  
Example of a tabbed page. Clicking a tab (1b) causes new content to replace the visible content in the white box.
</div>

In this case, the page author may indicate that the content for each tab represents a separate page of content. Each tab (specifically, each node wrapping the content for a tab) will contain one or more hPage elements. When the page is first loaded, only the hPage(s) contained within the visible content will be examined by the parser. The other tabs are marked as `hidden-on-load` and ignored by the parser.

<pre class="brush: html;">
    <p> In this example there are 3 hPages but only 1 is visible at a time to a user.</p>
    <ul class="tab-navigation">
      <li class="tab-nav selected">
        <a href="#tab-1">Tab 1</a>
      </li>
      <li class="tab-nav unselected">
        <a href="#tab-2">Tab 2</a>
      </li>
      <li class="tab-nav unselected">
        <a href="#tab-3">Tab 3</a>
      </li>
    </ul>
    <div id="tab-1" class="hpage tab selected">
      <h2 class="name">Tab One</h2>
      <p>
        Content for the primary tab, which is initially visible.
        This hPage is parsed when the page first loads.
      </p>
    </div>
    <div id="tab-2" class="hpage tab unselected">
      <h2 class="name">Tab Two</h2>
      <span class="hidden-on-load">true</span>
      <p>
        Hidden tab not parsed on first page load. 
      </p>
    </div>
    <div id="tab-3" class="hpage tab unselected">
      <h2 class="name">Tab Three</h2>
      <span class="hidden-on-load">true</span>
      <p>
        Content for tab three.
      </p>
    </div>
</pre>

<div markdown="1" class="caption">
Example HTML for a tabbed page.  
Note that the classes `tab-nav selected` and `tab selected` are page-specific CSS classes that control which tab is rendered as visible. The classes `tab-nav unselected` and `tab unselected` are page-specific CSS that indicate the header is greyed out and the content is not visible.  
The class `hidden-on-load` is hPage metadata indicating which hPages should not be parsed when the document is loaded.  
hPage metadata and CSS class names can be freely used on the same element where appropriate.
</div>

When the user clicks on a tab (1b), this fires a JavaScript event. The event handler makes a CSS change which causes the selected tab to be displayed. The event handler will additionally trigger the parser to look for hPages within the newly-displayed tab. The DOM node that is examined, `#tab-3` in this example, is called the *context* for the event. 

The parser will collect data from the hPage element(s) within this node, but not the rest of the document. The result will be composite of all hPages within that DOM node, whether marked as `hidden-on-load` or not.

### Syntax ###
To indicate that an hPage instance represents hidden content that is not shown to the user on the first page view, set the property `hidden-on-load` to *true*. Any hidden hPages will not be parsed until the parser is triggered specifically with the context of a node enclosing the island. If the page contains multiple hPage declarations, and they do not have the `hidden-on-load` property, then they will not be treated as distinct pages of content, and instead be merged to produce a single composite page view using the data declaration rules.

The parser *must* look for hPage declarations only within a defined context, which is a portion of the total page DOM to be scanned. If no context for the hPage is defined then the parser *should* assume that the context is the `<body>` element of the HTML document.

The parser *may* record the properties of `hidden-on-load` pages of content, but it must treat these as hidden, and consumers of the data *should not* treat these parsed values as indicating a page view event.

The parser *should* provide a mechanism for re-parsing a specific node of the DOM, when a user interaction causes new content to be shown. The mechanism for triggering this is parser-specific, and out of the scope of this specification.


## Content loaded following a user action ##
On many pages, content may be loaded via AJAX or remote script inclusion into the page, following a user interaction such as a button click. 

<div markdown="1" class="caption">
![Ajax Content](/images/hpage/ajax_content.png)  
Example of content inserted using AJAX.  
The static content in the background (2a) is visible when the page is first loaded.   
When the user interacts with the page, by clicking a button (2b) then new content is displayed (2c).
</div>

Again, the JavaScript event handler which loads the content should trigger the parser to parse only the DOM node enclosing the new content. The parser *should* data from any hPage elements in this node, even if they are marked as `hidden-on-load`. However, including `hidden-on-load` would be redundant and is not recommended, because the hPage was not present in the DOM during the initial parse.  

Consumers of the data found by the parser should treat the new hPage as a separate page view. In this way, a new view of content by the user generates a page view on the same footing, whether it comes from loading a separate URL, from revealing hidden content, or loading content into the page. 

### Syntax ###
In this case, there is no special property required in the markup. Because the hPage in this newly-loaded content did not appear in the DOM when the page was first loaded, it is not necessary to mark it as `hidden-on-load`.

The parser *should* provide a mechanism for parsing the new DOM nodes, when a user interaction causes new content to be loaded. The mechanism for triggering this is parser-specific, and out of the scope of this specification.


## Dynamic content fragments ##
A *page of content* is a complete page shown to the user. This could be the complete HTML document, or it may be displayed after a user interaction, as discussed in the previous sections. In either case, each page of content is composed of some static content, which is the same each time that page is loaded, plus zero or more dynamic content fragments.

A *dynamic content fragment* can be any region of content within a page. This may be a region of the page served separately from the main page, for example, a piece of content served by a recommendations engine, an A/B testing engine, or a behavioral targeting engine. It may also be content within the page selected by the main page CMS on the basis of the user's session or settings, for example, the widgets that appear on a customizable homepage.

<div markdown="1" class="caption">
![Mixed content](/images/hpage/mixed_content.png)  
Mixed content within a page.   
(3a) is a static content fragment, which is always the same on this page, and so does not normally need additional markup.   
(3b) and (3c) are examples of dynamic content fragments which may change with each page view.
</div>

This example might be represented with:

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">Microformat example</li>
        <li class="title">Page title</li>
      </ul>
    </div>

    ... static page content ...

    <div class="hpage">
      <ul class="content">
        <li class="id">324567635</li>
        <li class="group">The Geek Atlas</li>
        <li class="slot">top right</li>
      </ul>
      ... dynamic content ... 

      <ul class="content">
        <li class="id">475638765</li>
        <li class="group">Google ad</li>
        <li class="slot">bottom right</li>
      </ul>
      ... dynamic content ... 
    </div>
</pre>

It will not normally be necessary to mark the static content (i.e. content which is always shown on the same page name) as a content fragment, because it can be inferred from the page name. 

By marking up the content fragments, the page author will be able to collect information for web analytics about what content was displayed to the user in each page of content, and not just the URLs or page names that they loaded in the browser. This allows more accurate and more integrated reporting of, for example, the impact of different design variants served by A/B testing tools on behavior later in the session.

### Syntax ###
Each content fragment (represented by the `content` property) has a unique identifier in the `id`, which can be used to indicate that the same content is shown in different locations across the site. If a widget, advertisement or other content appears on multiple pages, then the same content ID should be used in each case, so that the views to this content can be recorded independently of the pages on which they were located.

The content may also have an optional thematic ID, in the `group` property. Different formats of the content which represent substantially the same proposition can be linked with the same group ID. One example is skyscraper and landscape banner ad layouts, where the group would be the name of the campaign. Another example is a design theme in an A/B test. The group is not limited to advertising and can be used wherever the 'same' content or proposition (as defined by the page author) is shown to the user in a different format. 

Any number of content fragments may be declared within an hPage, or in separate hPage declarations which are then combined according to the data declaration rules. 

Some systems may serve content into the page from a separate web server, for example via AJAX or remote scripts, and this content may be included in the page shortly after the consumer of the microformat has completed parsing. For example, a dynamic content server may respond to the page load event by loading content into the page, while the parser has also commenced parsing on the page load event.

In this case, the parser *should* consider the introduced content to be part of the same hPage, even if it has completed parsing. If the parser has already reported the data it has found to an external system, it should send a second message to the external system. The external system should treat this second message as part of the same event.

## Page types as tags ##
Page types in hPage are an important concept. The page type may correspond to a 'well known' type, and this can be used by consumers of the hPage data to infer additional information about the page. For example, the  ecommerce page types can be used to define a purchase funnel without any additional configuration being required to recognize page names. 

When a page is one of the existing enumerated types, page authors are encouraged to represent this with [rel-tag](http://microformats.org/wiki/rel-tag). When a type property is a rel-tag, the tag (as defined by rel-tag) is used for that type. 

The enumeration of types is not exhaustive and page authors are free to define their own types, either using rel-tag or as free text.

**The enumeration of "well known page types" is under discussion, and does not yet form part of this specification.**

One possible example of a well known page type might be for error pages, allowing error pages across all sites to be marked in a consistent way:

<pre class="brush: html;">
    <body class="hpage">
      <h1 class="name">Page not found</h1>
      <a class="type" rel="tag" href="http://www.jshub.org/hpage/types/404">Not Found Error</a>
      <p>The page you requested was not found on this server. 
        Please try the <a href="/">homepage</a>.
      </p>
    </body>
</pre>


## Page categories as tags ##
Categories in hPage may also be represented by tags with [rel-tag](http://microformats.org/wiki/rel-tag). When a category property is a rel-tag, the tag (as defined by rel-tag) is used for that category. 

Any categories may be used on the page, and there is no defined or recommended format.


## Parser rules and examples ##

### Singular vs. plural properties ###
We adopt singular class name equivalents for plural property and sub-property names.

For properties which are singular, the **last** descendant element with that class should take effect.

All other properties may be plural. Each class instance of such properties creates a new instance of that property.

### Value excerpting and the value class pattern ###
The value of each property is, in general, the inner text (including embedded html markup) of the element with the property name. Parsers *must* follow the rules defined for [basic parsing of microformat values](http://microformats.org/wiki/value-class-pattern#Basic_Parsing). For all properties in this specification with the exception of `attribute`, the rules are:
 1. if the value element is an `img` or `area` element, then use the element's `alt` attribute value.
 2. if the value element is an `abbr` element, then use the element's `title` attribute value.
 3. for any other element, use its inner-text.

### Simple values ###
For all textual properties (all hPage properties except for `attribute`), if the element is a non-empty html element, the parser *must* use the full inner html of the element as the value of the property. 

<pre class="brush: html;">
    <div class="hpage">
      Page name is <span class="name">hPage examples</span>.
    </div>
</pre>

The page name is "hPage examples".

### Value normalization ###

#### Whitespace ####
Whitespace is trimmed from the start and end of any values. Whitespace within a value string is normalized as per the rules of HTML, i.e. any sequence of spaces, tabs and newline characters is replaced with a single space.

<pre class="brush: html;">
    <div class="hpage">
      Note additional whitespace in source code:
      <ul>
        <li>page name is 
           <span class="name">
    	           page name 
    	           with newlines
           </span>
        </li>
      </ul>
    </div>
</pre>

is equivalent to:

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">page name with newlines</li>
      </ul>
    </div>
</pre>

#### Embedded html ####
Any embedded html is retained by the parser as part of the property value.

<pre class="brush: html;">
    <div class="hpage">
      Additional HTML in source code:
      <ul>
        <li>page name is
           <span class="name">page name with an <a href="test.html">embedded link</a></span>.
        </li>
      </ul>
    </div>
</pre>

The value of page name is `page name with an <a href="test.html">embedded link</a>`.

### Use of value class ###
In the case of the `attribute` property, the property has two fields, a type and a value. For this purpose, the special class name `value` is used to contain the subset of the element that is the value of the property. This is the "value class pattern", which is a special case of the normal rule where the whole of the element's content would be treated as the value. 

These examples are equivalent:

<pre class="brush: html;">
    <span class="attribute">
      <span class="type">discount</span>:
      <span class="value">10%</span>
    </span>
</pre>

<pre class="brush: html;">
    <span class="attribute">
      <p>Your <span class="type">discount</span>:of <span class="value">10%</span> has been applied</p>
    </span>
</pre>

If the `value` is not present, then there is an implicit value of "true". If neither `type` nor `value` are specified, then the type is taken to be the full content of the `attribute` node, with an implicit value of "true". So these examples are equivalent:

<pre class="brush: html;">
    <span class="attribute">
      <span class="type">discount</span>:
      <!-- implicit value = true -->
    </span>
</pre>

<pre class="brush: html;">
    <span class="attribute">discount</span>
    <!-- implicit value = true -->
</pre>

If the `value` is specified, but no `type`, then the attribute is invalid, and is ignored by the parser:

<pre class="brush: html;">
    <span class="attribute">
      <span class="value">10</span>:
      <!-- invalid, no attribute type to apply the value to  -->
    </span>
</pre>


### Properties with multiple values ###
The properties `category` and `type` take multiple, white-space separated values.

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li>Page categories:
          <span class="category">microformat spec web html web+analytics</span>
        </li>
      </ul>
    </div>
</pre>

is equivalent to:

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li>Page categories:
          <span class="category">microformat</span>
          <span class="category">spec</span>
          <span class="category">web</span>
          <span class="category">html</span>
          <span class="category">web analytics</span>
        </li>
      </ul>
    </div>
</pre>

### Use of rel-tag ###
The properties `category` and `type` can also be specified using [rel-tag](http://microformats.org/wiki/rel-tag), and this approach is recommended.

This example provides greater information than the opaque text labels of the previous examples.

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li>Page categories:
          <a class="category" rel="tag" href="http://www.example.com/tags/microformat">microformat</a>
          <a class="category" rel="tag" href="http://www.example.com/tags/spec">spec</a>
          <a class="category" rel="tag" href="http://www.example.com/tags/web">web</a>
          <a class="category" rel="tag" href="http://www.example.com/tags/html">html</a>
          <a class="category" rel="tag" href="http://www.example.com/tags/web+analytics">web analytics</a>
        </li>
      </ul>
    </div>
</pre>

The value of the category is the last path component of each URL, as specified by the rel-tag microformat. For example, the first category in this example is `microformat` and has a *tagspace* of `http://www.example.com/tags`.

By defining the tagspace as well as the category, this markup indicates that the category means the same as a category with the same rel-tag on another site. Without the tagspace, we cannot assume that the categories have the same meaning just because they have the same label.


### Additional patterns ###
In addition to the properties listed, the following patterns may be used within an hPage microformat, and should be implemented by parsers.

The [DEL element pattern](http://microformats.org/wiki/hcard-parsing#DEL_element_handling) may be used to indicate that certain information should be removed from the parsed data. The parser *should* skip any `<DEL>` elements and the data contained within them. 

The parser should obey the [include pattern](http://microformats.org/wiki/include) and parse included hCards in the author property.

Future versions of this microformat may support the ability to mark certain data fields as PII (personally identifying information), and mark certain fields as visible to some applications but not others.

## Exception case examples ##
The following examples demonstrate some possible errors in hPage markup and how they should be treated by the parser.

### Missing required fields ###
The hPage specification requires the *name* property which represents the page name. This example does not contain that:

<pre class="brush: html;">
    <div class="hpage">
      No hPage properties are set:
      <ul>
        <li>page name: required field, not present</li>
      </ul>
    </div>
</pre>

This is not a valid hPage and will not trigger a page view in the parser.

### Composition example with missing fields ###

<pre class="brush: html;">
    <div class="hpage">
      <ul>
        <li class="name">Homepage</li>
      </ul>
    </div>

    ... some other text ... 

    <div class="hpage">
      No hPage properties are set:
      <ul>
        <li>page-name: required field, not present</li>
        <li class="category">microformats</li>
      </ul>
    </div>
</pre>

The second hPage declaration in this document is not valid on its own. However because there is a previously declared hPage instance, the second instance supplements the information according to the composition rules.

