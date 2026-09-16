# What the loop closes before a single request is sent.
#
# `aat validate` does all its work and then prints one block, so there is nothing to animate: this
# tape exists to produce a still. It writes an MP4, and demos/run.sh takes its last frame as
# docs/images/demo-validate.png. A GIF of a report that appears all at once is just a screenshot
# that goes away.

Output demos/out/demo-validate.mp4

Require aat

Set Shell "bash"
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrains Mono"
Set FontSize 16
Set Width 1000
Set Height 420
Set Padding 20
Set Framerate 24
Set TypingSpeed 45ms
Set CursorBlink false

Hide
Type "clear"
Enter
Wait
Show

Sleep 500ms
Type "aat validate --strict"
Sleep 400ms
Enter
Wait@60s
Sleep 4s
