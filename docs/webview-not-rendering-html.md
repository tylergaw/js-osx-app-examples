# (NOTE: UNRESOLVED)

# JS for Automation: WebView not rendering HTML
https://devforums.apple.com/message/1034879#1034879

### Tyler Gaw - Sep 5, 2014 2:28 AM

Using JavaScript for Automation, I'm attempting to build a simple app that displays a web site in a WebKit WebView. WebKit seems to import as it should and I'm able to create the WebView and add it to the main NSWindow. I can load a URL using loadRequest and the page displays. However, it's rendered as plain text. No HTML, CSS, or JS is rendered in the WebView. This is the same will all URLs.

Can anyone tell if I'm missing something in the configuration of the WebView or something else?

Here's the app: https://www.dropbox.com/s/l35o42816rlcofm/TestWebView.zip?dl=0 You will need Yosemite Dev Preview. (best to have the latest, 7)

and here's the full code:

```javascript
ObjC.import("Cocoa");
ObjC.import("WebKit");

var url = $.NSURL.alloc.initWithString("http://craigslist.org");
var req = $.NSURLRequest.requestWithURL(url);

var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSMiniaturizableWindowMask | $.NSTexturedBackgroundWindowMask;

var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(
  $.NSMakeRect(0, 0, 600, 400),
  styleMask,
  $.NSBackingStoreBuffered,
  false
);

var webview = $.WebView.alloc.initWithFrameFrameNameGroupName(
  window.contentView.bounds,
  "framename",
  "groupname"
);

webview.mainFrame.loadRequest(req);

window.contentView.addSubview(webview);
window.center;
window.title = "WebView Example";
window.makeKeyAndOrderFront(window);
```
