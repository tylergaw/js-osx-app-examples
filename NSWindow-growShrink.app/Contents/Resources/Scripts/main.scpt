JsOsaDAS1.001.00bplist00�Vscript_:ObjC.import("Cocoa");

var width = 400;
var height = 300;
var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSMiniaturizableWindowMask;

var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(
	$.NSMakeRect(0, 0, width, height),
	styleMask,
	$.NSBackingStoreBuffered,
	false
);

var btnWidth = 120;
var btnHeight = 25;
var btn = $.NSButton.alloc.initWithFrame(
	$.NSMakeRect((width * 0.5) - (btnWidth * 0.5), 
	height * 0.5, 
	btnWidth, 
	btnHeight
));

btn.title = "Embiggen";
btn.bezelStyle = $.NSRoundedBezelStyle;
btn.buttonType = $.NSMomentaryLightButton;

ObjC.registerSubclass({
	name: "AppDelegate",
	properties: {
		isLarge: 'boolean'
	},
	methods: {
		"changeWindowSize:": {
			types: ["void", ["id"]],
			implementation: function (sender) {
				
				var curX = window.frame.origin.x;
				var curY = window.frame.origin.y;
				
				if (this.isLarge) {
					var newWidth = width;
					var newHeight = height;
					var newX = curX + width;
					var newY = curY + height;
				}
				else {
					var newWidth = width * 3;
					var newHeight = height * 3;
					var newX = newWidth * 0.3;
					var newY = newHeight * 0.3;
				}
				
				/*
				btn.setFrameOrigin({
					x: (newWidth * 0.5) - (btnWidth * 0.5), 
					y: newHeight * 0.5
				});
				*/
				
				/*
				window.setFrameDisplayAnimate(
					$.NSMakeRect(newX, newY, newWidth, newHeight),
					true,
					true
				);
				*/
				
				var newWindowFrame = $.NSMakeRect(newX, newY, newWidth, newHeight);
				var windowResize = $.NSDictionary.dictionaryWithObjectsAndKeys(
					window, 
					$.NSViewAnimationTargetKey, 
					$.NSValue.valueWithRect(newWindowFrame), 
					$.NSViewAnimationEndFrameKey, 
					$.nil
				);
				
				// NOTE: See if you can do this without recreating the frame
				var newBtnFrame = $.NSMakeRect((newWidth * 0.5) - (btnWidth * 0.5), newHeight * 0.5, btnWidth, btnHeight);
				var btnRepos = $.NSDictionary.dictionaryWithObjectsAndKeys(
					btn, 
					$.NSViewAnimationTargetKey, 
					$.NSValue.valueWithRect(newBtnFrame), 
					$.NSViewAnimationEndFrameKey, 
					$.nil
				);
				
				var animations = $([windowResize, btnRepos]);
				var animation = $.NSViewAnimation.alloc.initWithViewAnimations(animations);
				
				animation.animationBlockingMode = $.NSAnimationBlocking;
				animation.animationCurve = $.NSAnimationEaseIn;
				animation.duration = 0.25;
				animation.startAnimation;
				
				this.isLarge = !this.isLarge;
			}
		},
		"windowWillStartLiveResize:": {
			types: ["void", ["id"]],
			implementation: function (notification) {
				// Do some crud before the resize starts
			}
		},
		"windowDidEndLiveResize:": {
			types: ["void", ["id"]],
			implementation: function (notification) {
				// Do some crud we the resize is done.
			}
		}
	}
});

var appDelegate = $.AppDelegate.alloc.init;
appDelegate.isLarge = false;
window.delegate = appDelegate;

btn.target = appDelegate;
btn.action = "changeWindowSize:";
btn.keyEquivalent = "\r"; // Enter key

window.contentView.addSubview(btn);

window.center;
window.title = "NSWindow Grow/Shrink Example";
window.makeKeyAndOrderFront(window);                              Pjscr  ��ޭ