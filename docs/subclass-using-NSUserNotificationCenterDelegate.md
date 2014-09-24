# Subclass using NSUserNotificationCenterDelegate in JavaScript for Automation
https://devforums.apple.com/message/1023636#1023636

### Tyler Gaw - Aug 14, 2014 2:10 PM

I'm attempting to register a subclass–using ObjC.registerSubclass–that conforms
to NSUserNotificationCenterDelegate. I'm doing this create a demo where
NSUserNotifications are shown even when my app is the key application. To do that,
I need to override userNotificationCEnter:shouldPresentNotification:

I'm not getting any errors, it just appears to be choking on something while
attempting to register. The two calls to NSLog I've been using to see if **anything**
will happen.

The code I have so far.

```javascript
ObjC.import("Cocoa");

$.NSLog("This will be logged");

ObjC.registerSubclass({
  name: "MyNotification",
  protocols: ["NSUserNotificationCenterDelegate"],
  methods: {
    "userNotificationCenterShouldPresentNotification:": {
      implementation: function (center, notification) {
        return true;
      }
    }
  }
});

$.NSLog("This will not be logged");
```

### Tyler Gaw - Aug 14, 2014 6:13 PM

A bit more info: I do have the file saved as an Application and I have the Stay
open after run handler option checked.

### Tyler Gaw - Aug 14, 2014 7:40 PM

Guess I just needed to keep picking at it. I have it working now, and found
something interesting about ObjC.registerSubclass. Not sure if it's a bug or
intentional.

```javascript
ObjC.import("Cocoa");

ObjC.registerSubclass({
  name: "MyNotification",
  methods: {
    "userNotificationCenter:shouldPresentNotification:": {
      types: ["bool", ["id", "id"]],
      implementation: function (center, notification) {
        return true;
      }
    }
  }
});
```

I found out that the main culprit was my inclusion of NSUserNotificationCenterDelegate
in the protocols list. If protocol is included the registering of the subclass–and
anything after it–will fail silently. Leaving out the protocol had an effect on
the methods. I now have to have the types member of any methods. According to the
initial JS for Automation session video you do not have to include the types if
you are overriding a method of an existing class or protocol. Since I have to remove
the protocol, the types are needed. BTW: I couldn't find any docs on that types array
so as I understand it, it goes like this: types: ["the return type", ["arg 1 type", "arg 2 type"]].
There is an explanation of available types in the JS for automation release notes.

Only thing to note. Since I need to use a method of NSUserNotificationCenterDelegate,
the method signature needs to be exactely as it is in the docs. Meaning, you do
not remove any colons ":" separating parts. I assumed that those names would be
treated like other methods where "userNotificationCenter:shouldPresentNotification:"
should have been "userNotificationCenterShouldPresentNotification:". That was an
incorrect assumption.

OK, hopefully all of that is helpful to someone else. For reference, here is my
full script that displays a notification even if the app is the key application.
Happy coding!

```javascript
ObjC.import("Cocoa");

ObjC.registerSubclass({
   name: "MyNotification",
   methods: {
    "userNotificationCenter:shouldPresentNotification:": {
       types: ["bool", ["id", "id"]],
       implementation: function (center, notification) {
          return true;
       }
    }
   }
});

var myNotification = $.MyNotification.alloc.init;

$.NSUserNotificationCenter.defaultUserNotificationCenter.delegate = myNotification;

function showNotification (title, msg) {
  var notification = $.NSUserNotification.alloc.init;
  notification.title = title;
  notification.informativeText = msg;
  notification.soundName = $.NSUserNotificationDefaultSoundName;
  $.NSUserNotificationCenter.defaultUserNotificationCenter.deliverNotification(notification);
}

showNotification("Hello World", "This is a user notification.");
```

NOTE: A working example of the code in this thread can be found in the example app NSUserNotification.app
