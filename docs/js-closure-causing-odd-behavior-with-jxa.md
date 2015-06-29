# RESOLVED

# JS closure causing odd behavior with JXA
https://forums.developer.apple.com/thread/5208

### Tyler Gaw - June 14, 2015 12:52 PM EST

I'm using JXA to build Cocoa applications and running into a strange issue when attempting to wrap all an app's JavaScript with an immediately-invoked function expression.

**What's the issue?**

If the code for an app with a single NSWindow is wrapped in an immediately-invoked function, the app's window will close on it's own without any type of application crash. The app stays running.

**Here's the code I'm using:**

```javascript
(function() {  
  ObjC.import("Cocoa");  
  var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSResizableWindowMask | $.NSMiniaturizableWindowMask;  
  var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(  
    $.NSMakeRect(0, 0, 800, 400),  
    styleMask,  
    $.NSBackingStoreBuffered,  
    false  
  );  
  window.center;  
  window.title = 'NSWindow Closure Bug?';  
  window.makeKeyAndOrderFront(window);  
}());
```

Here's the example application https://dl.dropboxusercontent.com/u/271215/jsclosurebugexample.zip or recreate it with
- Script Editor > New
- Copy/paste the above code
- Save > File Format: Application, Options: Stay open after run handler (important)

Then Script > Run Application or double-click the application icon. That should open the app which is a single NSWindow.

If you leave the app running and window open, after about 2 min the window will close. The app stays running, just the window closes as if you'd clicked the "x" button. This does not happen if the wrapping function is removed like:

```javascript
ObjC.import("Cocoa");  
var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSResizableWindowMask | $.NSMiniaturizableWindowMask;  
var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(  
  $.NSMakeRect(0, 0, 800, 400),  
  styleMask,  
  $.NSBackingStoreBuffered,  
  false  
);  
window.center;  
window.title = 'NSWindow Closure Bug?';  
window.makeKeyAndOrderFront(window);  
```

**Why do I want to wrap the code in an immediately-invoked function?**

I'm starting to use JavaScript build processes to write JXA. I want to separate JS into modules and then compile them into a single JS file that will be compiled with osacompile to create the script needed for the application. In this case, I'm using Browserify which wraps all loaded modules in a similar function.

**What have I tried?**

When a window closes, the windowWillClose: message is sent. In another version of the above example I implemented an NSWindow delete and added an NSLog to the windowWillClose: message. If you close the window manually, the message is sent and the NSLog is trigger. When the window closes automatically, the message is not sent and the log isn't...logged.

Example:

```javascript
(function() {  
  ObjC.import("Cocoa");  

  ObjC.registerSubclass({  
    name: "WindowDelegate",  
    methods: {  
      "windowWillClose:": {  
        types: ["void", ["id"]],  
        implementation: function(sender) {  
          $.NSLog('CLOSED THE WINDOW');  
        }  
      }  
    }  
  });  

  var windowDelegate = $.WindowDelegate.alloc.init;  
  var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSResizableWindowMask | $.NSMiniaturizableWindowMask;  
  var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(  
    $.NSMakeRect(0, 0, 800, 400),  
    styleMask,  
    $.NSBackingStoreBuffered,  
    false  
  );  
  window.delegate = windowDelegate;  


  window.center;  
  window.title = 'NSWindow Closure Bug?';  
  window.makeKeyAndOrderFront(window);  
}());  
```

## Solution
### [username withheld cause I'm not sure I should share it] - June 23, 2015 3:52 PM EST

You must be experiencing JavaScript's garbage collection here. When the immediately invoked closure is cleaned up, the variables created inside are cleaned up as well (and your window goes away, because it has no variable referencing it anymore). To keep the window around, you will need a persistent variable in the global scope (which is why the non-closure version worked for you). You can accomplish this by either having a window variable outside of the closure that you set to an NSWindow inside the closure or declaring the window variable without the "var" keyword inside the closure (which will declare the window variable in the global scope). Here is code demonstrating these two approaches:

```javascript
var globalWindow = null;  
  
(function() {  
  
    ObjC.import('Cocoa');  
  
    // Helper function for window creation  
    function windowWithTitle(title) {  
  
        var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(  
            $.NSMakeRect(0, 0, 800, 400),  
            $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSResizableWindowMask | $.NSMiniaturizableWindowMask,  
            $.NSBackingStoreBuffered,  
            false  
        );  
  
        window.center;  
        window.title = title;  
        window.makeKeyAndOrderFront(window);  
  
        return window;  
    }  
  
    // Create one local window and two global windows  
    var localWindow = windowWithTitle('I will disappear');  
    globalWindow = windowWithTitle('I will stick around');  
    anotherGlobalWindow = windowWithTitle('I will also stick around');  
}()); 
```
