---
layout: articles
title: "Misc. Work"
permalink: /misc-work/
---

Presentations, essays, articles, etc.

{%for post in site.posts %}
{% if post.url contains 'paper' %}
<li><a href="{{site.url}}/dev_site2{{post.url}}">{{post.title}}</a></li>
{% endif %}
{% endfor %}