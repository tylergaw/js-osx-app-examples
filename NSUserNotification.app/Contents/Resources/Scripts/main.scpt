JsOsaDAS1.001.00bplist00�Vscript_9// NSUserNotification: https://developer.apple.com/librarY/mac/documentation/Foundation/Reference/NSUserNotification_Class/Reference/Reference.html#//apple_ref/occ/instp/NSUserNotification/soundName
//
// NSUserNotificationCenter: https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSUserNotificationCenter_Class/Reference/Reference.html#//apple_ref/occ/instp/NSUserNotificationCenter/delegate
//
// NSUserNotificationCenterDelegate: https://developer.apple.com/librarY/mac/documentation/Foundation/Reference/NSUserNotificationCenterDelegate_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/NSUserNotificationCenterDelegate/userNotificationCenter:shouldPresentNotification:

ObjC.import("Cocoa");

var windowWidth = 400;
var windowHeight = 210;
var fieldWidth = (windowWidth - 50);

var titleLabel = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (windowHeight - 40), fieldWidth, 24));
titleLabel.stringValue = "Title:";
titleLabel.drawsBackground = false;
titleLabel.editable = false;
titleLabel.bezeled = false;
titleLabel.selectable = true;

var titleField = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (windowHeight - 65), fieldWidth, 24));
titleField.stringValue = "Notification Title";

var msgLabel = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (windowHeight - 105), fieldWidth, 24))
msgLabel.stringValue = "Message:";
msgLabel.drawsBackground = false;
msgLabel.editable = false;
msgLabel.bezeled = false;
msgLabel.selectable = true;

var msgField = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (windowHeight - 154), fieldWidth, 48));
msgField.stringValue = "Notification Message";

var statusLabel = $.NSTextField.alloc.initWithFrame($.NSMakeRect(25, (windowHeight - 187), fieldWidth, 24));
statusLabel.drawsBackground = false;
statusLabel.editable = false;
statusLabel.bezeled = false;
statusLabel.selectable = true;

ObjC.registerSubclass({
	name: "AppDelegate",
	methods: {
		"showNotification:": {
			types: ["void", ["id"]],
			implementation: function (sender) {
				var notification = $.NSUserNotification.alloc.init;
				notification.title = titleField.stringValue;
				notification.informativeText = msgField.stringValue;
				notification.soundName = $.NSUserNotificationDefaultSoundName;
				notification.actionButtonTitle = "Acknowledge";
				
				$.NSUserNotificationCenter.defaultUserNotificationCenter.deliverNotification(notification);
			}
		},
		"userNotificationCenter:shouldPresentNotification:": {
			types: ["bool", ["id", "id"]],
			implementation: function (center, notification) {
				// Returning true here allows the notification to display even if the app is the key app
				return true;
			}
		},
		"userNotificationCenter:didDeliverNotification:": {
			types: ["void", ["id", "id"]],
			implementation: function (center, notification) {
				statusLabel.stringValue = "Delivered: " + formattedDate(notification.actualDeliveryDate);
			}
		},
		"userNotificationCenter:didActivateNotification:": {
			types: ["void", ["id", "id"]],
			implementation: function (center, notification) {
				statusLabel.stringValue = "Acknowledged: " + formattedDate(notification.actualDeliveryDate);
			}
		}
	}
});

var appDelegate = $.AppDelegate.alloc.init;
$.NSUserNotificationCenter.defaultUserNotificationCenter.delegate = appDelegate;

var styleMask = $.NSTitledWindowMask | $.NSClosableWindowMask | $.NSMiniaturizableWindowMask;
var window = $.NSWindow.alloc.initWithContentRectStyleMaskBackingDefer(
	$.NSMakeRect(0, 0, windowWidth, windowHeight),
	styleMask,
	$.NSBackingStoreBuffered,
	false
);

var btn = $.NSButton.alloc.initWithFrame($.NSMakeRect(windowWidth - 160, (windowHeight - 186), 140, 25));
btn.title = "Create Notification";
btn.bezelStyle = $.NSRoundedBezelStyle;
btn.buttonType = $.NSMomentaryLightButton;
btn.target = appDelegate;
btn.action = "showNotification:";
btn.keyEquivalent = "\r";

window.contentView.addSubview(titleLabel);
window.contentView.addSubview(titleField);
window.contentView.addSubview(msgLabel);
window.contentView.addSubview(msgField);
window.contentView.addSubview(statusLabel);
window.contentView.addSubview(btn);

window.center;
window.title = "NSUserNotification Example";
window.makeKeyAndOrderFront(window);

function formattedDate (date) {
	return $($.NSDateFormatter.localizedStringFromDateDateStyleTimeStyle(date, $.NSDateFormatterShortStyle, $.NSDateFormatterShortStyle)).js;
}                              O jscr  ��ޭ