---
layout: blog
title: Recent posts
---

{% if site.posts != empty %}
  <ul class="recent">
    {% for post in site.posts limit:10 %}
      <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
   &raquo; [More](archive.html)
{% else %}
  <p>The are no recent posts.</p>
{% endif %}

### Open Source Projects

<ul class="projects status">
  <li id="jshub-core-status"><a href="http://github.com/jshub/jshub-core/">jsHub Core</a> jsHub javascript library developer application.</li>
</ul>
