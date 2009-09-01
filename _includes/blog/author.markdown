<div class="author">
  Posted on <span class="date">{{ page.date | date_to_string }}</span> 
  {% if page.author %}
    by <span class="name"><a href="/about/" title="About {{ page.author }}">{{ page.author }}</a></span> 
  {% endif %}
  {% if page.categories != empty %}
    in <span class="categories">{{ page.categories | array_to_sentence_string }}</span> categories
  {% endif %}
  .
</div>