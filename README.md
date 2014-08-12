# JavaScript OS X App Examples

Starting with OS X 10.10, Yosemite you can use JavaScript to create native Cocoa
applications.

This is a collection of examples showing how to create many of the common components
used in OS X Applications. The goal is to help people learn how to build apps
by showing clear, atomic examples.

NOTE: You will need the OS X Yosemite Developer Preview to run any of the example
apps or edit their code.

### Running
You can run any of the example apps by double clicking them.

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

### Reference
[JavaScript for Automation Release Notes](https://developer.apple.com/library/prerelease/mac/releasenotes/interapplicationcommunication/rn-javascriptforautomation/index.html)

Check out the WWDC presentation on [JavaScript for Automation](https://developer.apple.com/videos/wwdc/2014/)
You'll need an Apple Developer Account.
