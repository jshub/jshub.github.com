---
layout: projects
title: Event API Project 
---

<p class="path noprint">
  <a class="pathentry" href="/">Home</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects/">Projects</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects/events/">Event API</a> 
  <br style="clear: both" />
</p>


# Proposal for an event API #

jsHub proposes a new syntax for declaring data about events that happen in the page, after the page has loaded. For example, to record button clicks, AJAX content loading, and movie start / stop events. The new syntax is based on a JavaScript event model.

The standard will consist of three elements:
 1. A structure for declaring an event object, in the form of a JSON object with validation rules.
 2. A dictionary of standard events. 
 3. An API for firing events, and for registering listeners for those events.

Events are represented by JSON (JavaScript) objects, which contain an event name, and zero or more attributes containing the data associated with the event. For example, a page view event will contain a page name attribute.

The event dictionary is an open list, so it is always possible to add new and custom events. The goal is not to try to produce a prescriptive list of all events that might occur. However, the standard events should be used where they are appropriate. This enables multiple products to "speak the same language" so that site owners can compare figures between different products in a neutral way.

Finally, the API provides a vendor neutral way for multiple libraries on the same page to fire, and listen to, events from different sources. 

Vendors can then provide a mapping from the events generated in the API to their own proprietary representation.