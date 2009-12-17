<div class="details">
  <a class="entry-title" href="{{ post.url }}" rel="bookmark">
    Posted
  </a>   
  on 
  <abbr class="date published updated" title="{{ page.date | date_to_xmlschema }}">
    {{ page.date | date_to_string }}
  </abbr> 
  {% if page.author %}
    <span class="vcard name author">
      <a href="/about/" class="url fn n uid" title="About {{ page.author }}">
        {{ page.author }}
      </a>
    </span> 
  {% endif %}
  {% if page.categories != empty %}
    in <span class="categories">{{ page.categories | array_to_sentence_string }}</span> categories
  {% endif %}
</div>