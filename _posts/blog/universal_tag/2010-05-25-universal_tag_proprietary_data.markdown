---
published: true
layout: post
categories: 
- universal tag
- markup
comments: true

title: Universal tag, proprietary data
author: Fiann O'Hagan
--- 

Tealium have recently posted an article entitled [What is Universal Tag?][tl] on their blog about the Tealium Universal Tag. It's a good article, and I agree with pretty much everything they say. 

In fact, I made some of the same points in my own [What is a Universal Tag?][fo] post.

 [tl]: http://www.tealium.com/blog/universal-tag/what-is-universal-tag-part-1/
 [fo]: /blog/2009/10/16/what_is_a_universal_tag/

However, there's one thing missing, because I don't think they go nearly far enough. The Tealium folks would like you to break out of the vendor lock-in caused by proprietary markup. I'd like to show you the next step on that path: avoiding the creation of your own proprietary format.

There are three levels of standardization that you could aim for with your markup.

## Level 1: proprietary mark-up ##

Here's the example given by Tealium, an invented example of product view data for a white shirt:

<pre class="brush: js;">
s.events="event1,prodView";
s.products=";cotton shirt;;;event1=4.5;evar1=large|evar2=white|evar3=4.5";
s.prop1="large";
s.prop2="white";
s.prop3="4.5";
</pre>

I worked at Omniture for a while, and although I think SiteCatalyst is a great product, I am no fan of their markup. We can see from this example that it's ugly, in fact really ugly. Not just that, but the syntax is actually broken in fundamental ways, for example that it doesn't have escape sequences so you can't have a comma in a product name. 

Because this is product-specific proprietary markup, it adds cost to your implementation process. It needs product-specific knowledge. This means either you waste time asking "does it need 3 or 4 apparently-random-semicolons in the middle?" or alternatively you need expensive consulting support.

And the markup can't be re-used for anything else. Omniture has a great solution in [Genesis][gn] where the data from the SiteCatalyst tags is fed to other products. In some circumstances, that is a cost effective method of implementing. But where the data is more complex, you end up with a lot of flaky glue code, including this from Omniture's own homepage:

 [gn]: http://www.omniture.com/en/products/marketing_integration/genesis

<pre class="brush: js;">
/*TNT FOOTER CONTINUED */
if(typeof mboxCreate == 'function') {
	
	var epi_offer_name;
	var epi_offer_product;
	var epi_offer_centricity;
	
	if(s.pageName==undefined)
		s.pageName=window.location;
	mboxCreate('global_page_vars', 'pageinfo_name='+s.pageName, 'pageinfo_section='+s.channel, ...);
}
/*TNT FOOTER END AGAIN */  
</pre>

This is a mapping from `s.pageName` in SiteCatalyst to `pageinfo_name` in another Omniture product, Test&Target. 

## Level 2: your own markup ##

Tealium's proposed solution is a very rational step forward from this. Create a data object in your own format, that meets your own business needs, and then map the fields into each of the tags you deploy on the site.

Here's the example they gave in their post:

<pre class="brush: js;">
  yourdata.product="cotton shirt",
  yourdata.size="large",
  yourdata.color="white",
  yourdata.rating="4.5",
  yourdata.page_type="product view",
</pre>

The SiteCatalyst product string can be easily constructed from this data. And at the same time, the data is a format which is much easier to understand, and hopefully easier to generate from the database.

Once the data is declared in the page in this format, it can be reused: it's relatively simple to write the mapping to SiteCatalyst, to Google Analytics or to whatever else you are using on the page. It's a great solution, and it's exactly the approach I have been using with some site implementations recently.

## Level 3: open format markup ##

But what if this data could be even more reusable? How about, for example, using the same data for improving your SEO?

The same data from this example could be represented in pure HTML, rather than using JavaScript:

<pre class="brush: html;">
  <div class="hproduct"> 
    <h1 class="fn">Cotton shirt</h1>
    <!-- Other data could include price, brand, category -->
    <ol class="xoxo">
      <li>
        <h2>Product details</h2>
        <dl>
          <dt>Color</dt>
          <dd>white</dd>
          <dt>Size</dt>
          <dd>large</dd>
        </dl>
      </li>
    </ol>
    <div class="hreview">
      <span class="fn">
        <a href="http://example.com/path/to/product" class="url">
          <img src="http://images.example.com/ratings_star_4_5.gif" alt="4.5 out of 5 stars"/>
        </a>
      </span>
      <span class="rating">4.5</span> / <span class="best">5</span>
    </div>
  </div> 
</pre>

This example combines three well-tested HTML microformats. The [hProduct microformat][hp] wraps the details of the product. I have added the product-specific information (color, size) in [XOXO format][xoxo], which allows arbitrary name-value pairs of data, and I have added the rating using [hReview][hr].

 [hp]: http://microformats.org/wiki/hproduct
 [xoxo]: http://microformats.org/wiki/xoxo
 [hr]: http://microformats.org/wiki/hreview

This looks a lot more verbose than the JS examples, and it is. But don't forget, this is the actual content of the page, it's not an additional hidden page weight on top. With the right CSS styling, this html structure will be precisely what is used to render the page for the user.

And this takes us to the next level, because we remove the duplication between the visible content on the page, and the data used for the web analytics tags. The microformat data will be parsed by search engine spiders and price comparison engines as they read the page. The same data is parsed by a microformat engine in JavaScript to populate the data into the tags. So a single source of data is used to populate SiteCatalyst, Google Analytics, but also for search engine activity.

<div class="wsd" wsd_style="napkin"><pre>
  Your server -> Search engine: Load HTML page
  note over "Search engine": 
    Parse microformats server side
    and list your product
  end note

  Your server -> Browser: Load HTML page
  note over Browser: Parse microformats in JS
  Browser -> Web analytics: Pass data
</pre></div>
<script type="text/javascript" src="http://www.websequencediagrams.com/service.js"><!-- --></script>


jsHub provides the microformat parser which can read this data, and pass it into your web analytics tags. I encourage you to try it out.