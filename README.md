# JavaScript OS X App Examples

### Updates

**09/02 - YOSEMITE DEVELOPER PREVIEW 7 NOTE:**

Developer preview 7 has fixed the major issues that were in dev preview 5. All of
the demos are working again.

I updated the Radar: http://openradar.appspot.com/radar?id=6472227281174528

**08/14 - YOSEMITE DEVELOPER PREVIEW 5/6 NOTE:**

A good number of the demos are crashing. Any demo that has a button that you can click
that does something will crash. (HandleBtnClick, NSOpenPanel, etc.)

I have a question up on the Apple dev forums:
https://devforums.apple.com/thread/240935?tstart=150

I've submitted a bug to Apple, and it's copied on Radar:
http://openradar.appspot.com/radar?id=6472227281174528

### What is this?

Starting with OS X 10.10, Yosemite you can use JavaScript to create native Cocoa
applications. I wrote a [big ole post](http://tylergaw.com/articles/building-osx-apps-with-js) to help get you started.

This is a collection of examples showing how to create many of the common components
used in OS X Applications. The goal is to help people learn how to build apps
by showing clear, atomic examples.

These aren't exhaustive examples. Most of them are as basic as possible. The idea
isn't to show everything that can be done, it's to give a solid foundation to get you started.

**NOTE: You will need the OS X Yosemite Developer Preview to run any of the example
apps or edit the code.**

### Running
You can run any of the example apps by double clicking them.

If you are running the app while editing from Script Editor, there are two different ways.
Script > Run (cmd + r) is the normal run. This can be good for quick debugging, but
the app will not act like the application and is usually not what you want. You'll
want Script > Run Application  (cmd + opt + r).

### Editing
To view and edit the code for each example you will need to use the Script Editor
application. It is located in Applications > Utilities > Script Editor. From there
you can either File > Open any of the example apps or drag the example app icon
to the Script Editor in the dock.

### How to create an app
Since using JavaScript to create apps is new there's not much documentation. We've
had the ability to do all of this with AppleScript for years, but I haven't had
much luck finding thorough docs on that either.

Here's a couple of gotchas that had me scratching my head for some time.

To create a new application:
- Open a new document in Script Editor cmd+n
- Save the document cmd+s
- When prompted with the Save dialog, name your app, set the file format to Application, and
make sure you check the Stay open after run handler option.

![](http://f.cl.ly/items/0h0R390u343T2d0q0723/newapplication.png)

**NOTE**: If you do not check the Stay open... option on the save dialog there does
not appear to be a way to update this later. (I hope I'm wrong, but haven't found a way to do it yet).
If the option isn't checked pretty much nothing is going to work how you expect it.

### Code Signing
Apps created this way can be code signed. Signing your app is helpful if you are
planning to distribute it to other people. Code Signing is a broad topic, for details
check out [http://macosxautomation.com/mavericks/codesign/index.html](http://macosxautomation.com/mavericks/codesign/index.html)

### Reference
[JavaScript for Automation Release Notes](https://developer.apple.com/library/prerelease/mac/releasenotes/interapplicationcommunication/rn-javascriptforautomation/index.html)

Check out the WWDC presentation on [JavaScript for Automation](https://developer.apple.com/videos/wwdc/2014/)
You'll need an Apple Developer Account.
