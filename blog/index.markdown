---
layout: blog
title: Latest News
---

{% if site.posts != empty %}
  <ul class="recent">
    {% for post in site.posts limit:5 %}
      <li class="hentry">
        <abbr class="published updated" title="{{ post.date | date_to_xmlschema }}">
          {{ post.date | date_to_string }}
        </abbr> 
        &raquo; 
        <a class="entry-title" href="{{ post.url }}" rel="bookmark">
          {{ post.title }}
        </a>
        {% if post.author %}
          <span class="vcard name author" style="display:none">
            <a href="/about/" class="url fn n uid" title="About {{ post.author }}">
              {{ post.author }}
            </a>
          </span> 
        {% endif %}      
      </li>
    {% endfor %}
  </ul>
   &raquo; [More](archive.html)
{% else %}
  <p>The are no recent posts.</p>
{% endif %}

<h3>Commentary</h3>

{% include tweets.html %}

### Open Source Projects

<ul class="projects status">
  <li id="jshub-core-status"><a href="http://github.com/jshub/jshub-core/">jsHub Core</a> jsHub javascript library developer application.</li>
</ul>
