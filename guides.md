---
layout: articles
title: "Guides"
permalink: /guides/
---

Here, you'll find guides I prepared.

#### [Website Initialization Guide]({{ site.url }}{{ site.baseurl }}/guides/initialization)

#### [Getting Started with Proteus 8]({{ site.url }}{{ site.baseurl }}/guides/Proteus)

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