---
layout: static
title: Tag Inspector
--- 

<p class="path noprint">
  <a class="pathentry" href="/">Home</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects">Projects</a> 
  <span class="pathentry sep">/</span>
  <a class="pathentry" href="/projects/inspector">Inspector</a>
  <br style="clear: both" />
</p>

# jsHub Tag Inspector #

The Inspector provides a d visual interface to the tag. spud

 * [See the Inspector in the demo store](/retail2/)

The Inspector is currently deployed as a script in the page. It will shortly be available as an installable browser extension. This means that any web professionals working on the site can install the inspector and see reports and warnings, without the page weight of delivering the code to all end users.

## How does it work? ##
The Inspector does not read markup directly from the page. Instead, it listens to the events generated within the [jsHub tag](/projects/jshub/). 

So you can use the Inspector to compare the markup that appears on the page, with the values actually found by the parser.

The demo store has [HTML microformat markup](/projects/markup/) on the pages. Since the Inspector is not directly reading markup, you can use it to check the markup in any format for which you have the relevant plugin installed.

## Screenshots ##

![Inspector launcher](/images/inspector/1InspectorLauncher.png)
![Inspector status view](/images/inspector/2InspectorStatus.png)
![Inspector event overview](/images/inspector/3InspectorOverview.png)
![Page events shown in the inspector](/images/inspector/4InspectorPageEvents.png)
![Data sources view](/images/inspector/5InspectorDataSources.png)

## Visual warning for markup issues ##
The Inspector will provide a visual warning for common markup issues that can occur on the page. For example, if you have more than one type of markup on the page, there may be a conflict in the data declared in each markup, with a page name specified differently in two places. 

The Inspector will highlight this problem and help site professionals to maintain the quality of their markup.

## Tag configuration reports ##
The Inspector checks the plugins installed in the tag on the page. Click the **Data sources** panel to see information about each plugins installed in the tag on the page. 

## Always ensure the latest tag is installed ##
The Inspector also runs some standard tests when it is opened. It attempts to contact the server that was used to generate the tag file, and checks whether the latest version of the tag is installed on the page. This is done with a SHA1 hash of the full code of the file, which means that it will detect if the file has been tampered with, or is simply out of date.

## Technology ##
The Inspector user interface is built on the [Yahoo User Interface](http://developer.yahoo.com/yui/) widget library.

Inspector code is developed in a Ruby on Rails [developer app](/ui/) with wireframe layouts for all the states of CSS and unit tests for the JavaScript event model.