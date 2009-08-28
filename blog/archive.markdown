---
layout: blog
title: Archive
---

{% if site.posts != empty %}
  <ul class="archive">
    {% for post in site.posts %}
      <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% else %}
  <p>The are no previous posts.</p>
{% endif %}
