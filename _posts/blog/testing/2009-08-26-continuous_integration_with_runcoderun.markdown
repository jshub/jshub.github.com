--- 
published: true
layout: post
categories: 
- javascript
- testing
comments: true

title: Continuous Testing with RunCodeRun
author: Liam Clancy
feature: featured_project_core.html
--- 

When building any Javascript library for public (or internal) use, the supply of good tests is very important. They not only protect the code-base from the unintentional breakage when adding or removing features, but also provide a useful means to demonstrate all the features of the library in a practical manner, in many cases replacing the need for extensive documentation.

This is the first in a series of posts to discuss how we have deeply integrated testing into our Javascript development process, starting first with **Continuous Testing**.

We have been using [Hudson][] as our [Continuous Integration][ci] server from *Day One&trade;*. Although it is commonly associated with Java projects, we built ourselves the means to automate the tests at the start of the project. 

We knew would get a good return on our investment for ourselves and in the visibility this gave to our sponsors that *Stuff Is Happening&trade;*.

  [hudson]: https://hudson.dev.java.net/
  [ci]: http://en.wikipedia.org/wiki/Continuous_integration

When deciding to share our code we thought it important that we were also sharing the [real-time results][results] of these tests so other developers could have confidence:

![RunCodeRun real-time results](/images/posts/2009-08/runcoderun_results.png)

1. in the quality of our code
1. in our commitment to fixing bugs and other problems in a timely manner
1. in trusting that the code does what we say it does and nothing else

## How we did it

Originally we intended to set-up a public instance of Hudson, but became impressed with [RunCodeRun][rcr]'s ease of use and built-in integration with Github (which we saw on other [projects][rcr-blue-ridge]).

  [rcr]: http://runcoderun.com/
  [rcr-blue-ridge]: http://runcoderun.com/relevance/blue-ridge
  
Since we already had an automated system to run tests in the form of our [Rails Plug-in][plugin] it was relatively easy to adapt our [Hudson build task][src-hudson-rake] `jshub:hudson:build` to be run in the new environment and get RunCodeRun to use it:

1. The *entry point* for RunCodeRun is to run the [default][rcr-doc-default] Rake task. 

    [Rake][] is a build system written in Ruby, is OS agnostic and very suitable for scripting common repetitive tasks in any language without a lot of overhead. It's the default build system for Ruby on Rails projects like our development application [**jshub-core**][].

1. Since we have our own task that kicks off all the tests and manages the environment we have to set this correctly as the *default* for RunCodeRun:

    <pre class="brush: ruby; gutter: false;">
    # override the default task as it calls just 'rake'
    Rake::Task[:default].prerequisites.clear
    desc "Override the default task for RunCodeRun"
    task :default => ["jshub:runcoderun:build"]
    </pre>

1. Running `rake -T default` we can see our task is now the default:

    <pre class="brush: bash; gutter: false;">
    $ rake -T default
    rake default  # Override the default task for RunCodeRun
    </pre>

  [plugin]: http://github.com/jshub/jshub-core/tree/master/vendor/plugins/jshub_javascript_tester
  [src-hudson-rake]: http://github.com/jshub/jshub-core/blob/master/vendor/plugins/jshub_javascript_tester/tasks/hudson.rake
  [src-rcr-rake]: http://github.com/jshub/jshub-core/blob/master/vendor/plugins/jshub_javascript_tester/tasks/runcoderun.rake
  [rcr-doc-default]: http://support.runcoderun.com/faqs/builds/top-level-rakefile-and-default-task
  [rake]: http://rake.rubyforge.org/
  [jshub-core]: http://github.com/jshub/jshub-core

Now whenever we commit changes to our repository on Github RunCodeRun is able to run all our tests automatically! 

I'm particularly happy with this approach as we are still able to continue running tests on our internal Hudson server, as well as locally, increasing the chance of us capturing any test failures due to differences in the environment. 

Since we have no access to RunCodeRun's server we can also be fairly certain that we are not depending on any specific *magic* of our own, conscious or unconscious, and so the tests should pass for everyone.

## Publishing results

You can see our test results on RunCodeRun [here][results], and we also provide the build status directly on the [project page][build-status] thanks to this [post](http://abedra.github.com/2009/06/05/getting-rcr-status-for-a-specific-project.html):

![Project build status](/images/posts/2009-08/build_status.png)

  [results]: http://runcoderun.com/jshub/jshub-core
  [build-status]: https://jshub.org/core/website/

One thing missing in comparison to Hudson is the reporting of individual test failures:

![Hudson results](/images/posts/2009-08/hudson_results.png)

We have put a lot of work into making the raw test log very readable for local development so you can still easily see a breakdown of tests in the RunCodeRun output. e.g.

<pre class="brush: text; gutter: false;">
jslint: 0 issues in api.js using core rules
jslint: 0 issues in hub.js using core rules
jslint: 0 issues in data-transport/sample-post-plugin.js using adsafe rules
jslint: 0 issues in data-transport/sample-get-plugin.js using adsafe rules
jslint: 0 issues in data-capture/technographic-plugin.js using adsafe rules
etc.

Unit Test Report: 2 Passed, 0 Failed, 2 Ignored, 4 Total tests in 23ms for form_transport/base.html.erb
Unit Test Report: 4 Passed, 0 Failed, 0 Ignored, 4 Total tests in 7ms for hub_configuration_test.html.erb
Unit Test Report: 12 Passed, 0 Failed, 0 Ignored, 12 Total tests in 32ms for hub_events_test.html.erb
Unit Test Report: 11 Passed, 0 Failed, 0 Ignored, 11 Total tests in 43ms for image_transport/api_test.html.erb
etc.
</pre>

More information on how exactly our tests run can be found in the jshub-core project [help](http://jshub.org/core/website/help/testing_plugin.html#running_the_unit_tests_in_a_headless_browser).

## Next steps

I wish more projects did this. 

Whilst its often easy to download code and run tests locally, if you are dependent on 3rd party libraries you really want to have the same safety net and early warning of potential problems you have for own code.

In our case the jsHub Javascript library makes use of features in [jQuery][] and so we are watching with interest as John Resig releases his [TestSwarm][] project to see how it complements or replaces our approach. We hope to be able to do a review of TestSwarm soon.

  [jquery]: http://jquery.com/
  [testswarm]: http://testswarm.com/