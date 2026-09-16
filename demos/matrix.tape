# The matrix recording: one plan file per lane, crossed with every parcel.
#
# No --quiet. The whole point is watching eight runs go by, each with its own banner and its own
# step lines — the batch's own scroll is the demonstration. Sequential, not --parallel: the
# sequential renderer appends, so it scrolls honestly, where the parallel one redraws bars in
# place and erases them at the end.
#
# Writes demos/out/demo-matrix.gif.

Output demos/out/demo-matrix.gif

Require aat

Set Shell "bash"
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrains Mono"
Set FontSize 13
Set Width 1180
Set Height 820
Set Padding 20
Set Framerate 24
Set TypingSpeed 35ms
Set CursorBlink false

Hide
Type "clear"
Enter
Wait
Show

Sleep 500ms
Type "aat run batch matrix --layer-group parcel-letter,parcel-large,parcel-heavy"
Sleep 400ms
Enter
Wait@240s
Sleep 4s
