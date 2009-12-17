<div class="author">
  Posted on 
    <abbr class="date published" title="{{ page.date }}">
      {{ page.date | date_to_string }}
    </abbr> 
  {% if page.author %}
    <span class="vcard name">
      <a href="/about/" class="url fn n uid" title="About {{ page.author }}">
        {{ page.author }}
      </a>
    </span> 
  {% endif %}
  {% if page.categories != empty %}
    in <span class="categories">{{ page.categories | array_to_sentence_string }}</span> categories
  {% endif %}
  .
</div>