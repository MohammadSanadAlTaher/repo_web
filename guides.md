---
layout: articles
title: "Guides"
permalink: /guides/
---

Here, you'll find guides I prepared.

#### [Website Initialization Guide](https://mohammadsanadaltaher.github.io/guides/initialization)

#### [Getting Started with Proteus 8](https://mohammadsanadaltaher.github.io/guides/Proteus)

<p>&nbsp;</p>
<p>&nbsp;</p>
----
<p>&nbsp;</p>
<p>&nbsp;</p>

{%for post in site.posts %}
{% if post.url contains 'guides' %}
<li><a href="{{site.baseurl}}{{post.url}}">{{post.title}}</a></li>
{% endif %}
{% endfor %}