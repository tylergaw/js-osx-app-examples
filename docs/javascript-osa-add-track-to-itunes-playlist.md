#Javascript OSA, add track to iTunes playlist
https://devforums.apple.com/message/1044316

### [forumuser*] Jul 15, 2014 12:20 PM

I'm trying to get a track from one playlist and then add it to another playlist using Javascript in the ScriptEditor.  To illustrate what I want to do, here is a working _AppleScript_ doing exactly the correct thing:

```
tell application "iTunes"

     set sourcePlaylistName to "Source"
     set targetPlaylistName to "Target"

     set sourcePlaylist to user playlist sourcePlaylistName
     set targetPlaylist to user playlist targetPlaylistName

     set sourceTrack to first track of sourcePlaylist

     duplicate sourceTrack to targetPlaylist

end tell
```

I'm sorry the Javascript version is not as neat looking, because I have sprinkled console.logs to try to sort out what is going wrong:

```javascript
var sourcePlaylistName = "Source";
var targetPlaylistName = "Target";

var iTunes = Application("iTunes");
var library = iTunes.sources[0];
var sourcePlaylist = library.playlists[sourcePlaylistName];
var targetPlaylist = library.playlists[targetPlaylistName];


console.log("sourcePlaylist name: " + sourcePlaylist.name() + " track count: " + sourcePlaylist.tracks.length);
var sourceTrack = sourcePlaylist.tracks[0];
console.log("sourceTrack.name: " + sourceTrack.name());

console.log("targetPlaylist name: " + targetPlaylist.name() + " track count: " + targetPlaylist.tracks.length);

//targetPlaylist.tracks.push(sourceTrack); // --> Error -1700: Can't convert types.
console.log("Duplicating...")
iTunes.duplicate(sourceTrack, targetPlaylist);

console.log("sourcePlaylist name: " + sourcePlaylist.name() + " track count: " + sourcePlaylist.tracks.length);
console.log("targetPlaylist name: " + targetPlaylist.name() + " track count: " + targetPlaylist.tracks.length);

```

The output of running the Javascript version is:

```
/* sourcePlaylist name: Source track count: 1 */
/* sourceTrack.name: They're Coming To Take Me Away Ha-Haaa! */
/* targetPlaylist name: Target track count: 0 */
/* Duplicating... */
/* sourcePlaylist name: Source track count: 2 */
/* targetPlaylist name: Target track count: 0 */
```

As you can see, the track is duplicated into the source playlist rather than being added to the target playlist, as if the targetPlaylist is being ignored in the duplicate.  The events for the Javascript version are:

```
app = Application("iTunes")

     app.sources.at(0).playlists.byName("Source").name()

     app.sources.at(0).playlists.byName("Source").tracks.length

/* sourcePlaylist name: Source track count: 1 */

app = Application("iTunes")

     app.sources.at(0).playlists.byName("Source").tracks.at(0).name()

/* sourceTrack.name: They're Coming To Take Me Away Ha-Haaa! */

app = Application("iTunes")

     app.sources.at(0).playlists.byName("Target").name()

     app.sources.at(0).playlists.byName("Target").tracks.length

/* targetPlaylist name: Target track count: 0 */

/* Duplicating... */

app = Application("iTunes")

     app.duplicate(app.sources.at(0).playlists.byName("Source").tracks.at(0))

     app.sources.at(0).playlists.byName("Source").name()

     app.sources.at(0).playlists.byName("Source").tracks.length

/* sourcePlaylist name: Source track count: 2 */

app = Application("iTunes")

     app.sources.at(0).playlists.byName("Target").name()

     app.sources.at(0).playlists.byName("Target").tracks.length

/* targetPlaylist name: Target track count: 0 */
```

And, indeed, it does seem like the duplicate only has one argument.

Can anyone spot where I'm going wrong?

As an aside, I initially tried the push (which is commented out in the Javascript) and that returns an error.  I tried that because I recalled a slide from the WWDC presentation which pushed a new mail message into the Outgoing Messages.  It seems like the push would be a more sensible solution than the duplicate, so if you can help me get that working, I'd appreciate it.

Thank you

** *I'm not sure I should name other users in these docs? **

### Tyler Gaw - Aug 20, 2014 12:50 PM

Hey [forumuser], it's been a while so not sure if you're still looking for input on this, but I spent some time and got it working. It definitely had me scratching my head for while too.

The duplicate method takes an optional second parameter for where to duplicate the track. That parameter needs to be an object with a "to" member.

```
track.duplicate({to: targetPlaylist});
```

The docs for that–and all the similar docs–aren't very clear. Could just be some weirdness in the transition to JS I suppose. I found out that worked by just trying a bunch of stuff until something worked.

I wrote the script a bit different than your example. I'm not sure that accessing playlists by there name is supported anymore so

```
var sourcePlaylist = library.playlists[sourcePlaylistName];
```

would need to be changed. I wrote a quick function to find playlists by name to do something similar. Here's my full script

```javascript
var iTunes = Application("iTunes");

var library = iTunes.sources[0];
var sourcePlaylist = getPlaylistByName(library.playlists, "Source");
var targetPlaylist = getPlaylistByName(library.playlists, "Target");

var track = sourcePlaylist.tracks[0];
track.duplicate({to: targetPlaylist});


console.log("Duplicated " + track.name() + " to " + targetPlaylist.name());

function getPlaylistByName (lists, listName) {
  var playlist = null;


  for (var i = 0; i < lists.length; i += 1) {
    var l = lists[i];
      if (l.name() == listName) {
        playlist = l;
        break;
      }
  }

    return playlist;
}
```

### [forumuser*] Sep 17, 2014 7:59 AM

Tyler,  Thanks so much for the thorough response; I had in fact given up on the whole thing and decided to do what I wanted to do by writing out an xml file, reading it in Swift and writing another xml file and importing that in iTunes!  So, your answer provides a gleam of hope that I can get back to a less cumbersome workflow.

I would never have come up with '{to: targetPlaylist}' unless I had accidentally typed it whilst bashing my head against the keyboard in frustration.
