---
published: true
layout: post
categories: 
- markup
comments: true

title: Adopting microformats, one step at a time
author: Fiann O'Hagan
--- 

<div class="pullout note">
  <p>This is part of my ongoing series about the concept of a Universal Tag. The previous article considered a standard format for <a href="/blog/2009/10/30/beyond_the_pageview/">events recorded in JavaScript</a>. This time, I am asking the question of whether there is any point in adopting microformats right now.</p>
</div>

Here at jsHub, we believe that the future of markup is to encode the information in the HTML of the page, not in JavaScript language variables. There are a lot of reasons for doing this, but they all come back to one fundamental point:

<div class="pullout info">
  <p>Markup is data, not code</p>
</div>

I spent the best part of 10 years of helping customers implement tags, and I have seen all manner of ways to screw it up. The biggest reasons data in JavaScript so often doesn't work both come down to the different purposes that the HTML and JavaScript languages were created for. 

First, JavaScript is a programming language, and even the smallest syntax mistakes in the data can break data capture completely, as Liam pointed out in his discussion of [the design decisions in hPage][lc]. In contrast, HTML has a very liberal parser, which makes best endeavors to get something useful from even the worst tag soup.

  [lc]: /blog/2009/10/19/designing-hpage/

Second, HTML can be validated and parsed without being executed. This means that the data is *more useful*, because it can be read by all sorts of applications.

There are several ways to encode metadata within HTML. Perhaps the most important of these is known as **microformats**. The semi-official home, [microformats.org][mf], has loads more information on how to implement this data, and what applications can already consume it. 

  [mf]: http://microformats.org/


# Getting started with microformats #

So what is a microformat? Here's an example - [cookware][ws] from Williams-Sonoma. This page is marked up with [hProduct][hp] microformat data, and I have indicated a few of the places where microformats are used on this screenshot:

 ![Screenshot of Williams-Sonoma product page][ss]

 [ws]: http://www.williams-sonoma.com/products/le-creuset-5-quart-round-dutch-oven/
 [hp]: http://microformats.org/wiki/hproduct
 [ss]: /images/posts/2010-05/williams-sonoma-product-page-thumb.png

Let's take some examples from the HTML code on this page:

<pre class="brush: html;">
<div id="content" class="hproduct"> 
...
<h1 id="product-title" class="fn">Le Creuset Round Dutch Oven, 5 1/2-Qt.</h1>
...
<span class="price">$235.00</span>
...
<img alt="Le Creuset Round Dutch Oven, 5 1/2-Qt., Red" src=".../img28m.jpg" class="photo" id="hero-image"/>
</div>
</pre>

This is just a small snippet from the HTML, but it gives a good idea of how a microformat looks.

*Line 1:* the `div` with a class of `hproduct` indicates that the hProduct microformat is being used. The microformat defines some well known class names, which are applied to HTML elements within the div. The microformat doesn't change the HTML, it just adds some machine-readable hints to tell parsers what particular elements represent.

*Line 3:* one of the required class names within hProduct is `fn`, which is short for 'formatted name'. So this `h1` element is not just the heading for the page, it's also the name of the product which is represented in the hProduct.

*Line 5:* the class name `price` indicates the selling price for the product.

*Line 7:* the class name `photo` states that this is an image of the product.

Retailers are using this markup because it helps their SEO activities. In fact, this should make every webmaster start thinking seriously about using microformats. [Google indexes microformats][google], and [Yahoo indexes microformats][yahoo], and Bing are at least ['looking into it'][bing]. You should make it a core part of your SEO activities.

  [google]: http://googlewebmastercentral.blogspot.com/2009/05/introducing-rich-snippets.html
  [yahoo]: http://developer.yahoo.com/searchmonkey/smguide/semantic_web.html
  [bing]: http://www.bing.com/community/forums/p/647235/9537209.aspx


# Microformats and web analytics #

At first sight, this is a completely separate activity from implementing web analytics. But it doesn't have to be. Let's look at how the same data might be represented in Omniture SiteCatalyst (this is a made up example, not taken from the page).

<pre class="brush: js;">
s.events="event1,prodView";
s.products=";Le Creuset Round Dutch Oven 5 1/2-Qt;;;event1=80;evar1=Red";
s.prop1="red";
</pre>

The SiteCatalyst code contains the product name. Notice that there's some pre-processing required: the product name cannot contain certain characters including a comma. So someone has to fix the name before it goes into SiteCatalyst. Also notice that the data has to be escaped for JavaScript, so if the product is a 6" nail rather than a 5 1/2 qt pan, then you need to be careful with the quote.

How much easier it would be, if the product data for web analytics were populated from the same microformat data used for SEO.

It can be -- jsHub tags read hProduct markup, and convert it into product view events for web analytics tags.

# Microformats for web analytics #

Hopefully, this is a convincing argument that microformat data is a good potential alternative to proprietary JavaScript markup.

However, there's currently no agreed microformat that you can use for core web analytics data: for page names, site map categories, and other attributes of page view events such as author.

We have started to think about a possible way of declaring this data as a microformat (tentatively called hPage), but this is currently not a standard in any sense of the word. It is nothing more than a suggestion for how we think a microformat for web analytics data might look.

I have a firm intention to hand over hPage to [microformats.org][mf], if the good people there will have it. We don't take anything for granted, but we're serious about supporting it long term, and right now there is no microformat for data about the page.

In the meantime, start by marking up your ecommerce with hProduct. It will get indexed by search engines, and jsHub tags can read it. 