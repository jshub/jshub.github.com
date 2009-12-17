---
layout: blog
title: Archive
---

{% if site.posts != empty %}
  <ul class="archive">
    {% for post in site.posts %}
      <li class="hentry">
        <abbr class="published" title="{{ post.date | date_to_xmlschema }}">
          {{ post.date | date_to_string }}
        </abbr> 
        &raquo; 
        <a class="entry-title" href="{{ post.url }}" rel="bookmark">
          {{ post.title }}
        </a>
      </li>
    {% endfor %}
  </ul>

{% else %}
  <p>The are no previous posts.</p>
{% endif %}
