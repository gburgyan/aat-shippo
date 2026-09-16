# What the loop closes before a single request is sent.
# Writes demos/out/demo-validate.gif.

Output demos/out/demo-validate.gif

Require aat

Set Shell "bash"
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrains Mono"
Set FontSize 16
Set Width 1000
Set Height 480
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
