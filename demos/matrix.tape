# The matrix recording: one plan file per lane, crossed with every parcel.
# Writes demos/out/demo-matrix.gif.

Output demos/out/demo-matrix.gif

Require aat

Set Shell "bash"
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrains Mono"
Set FontSize 14
Set Width 1180
Set Height 720
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
Type "aat run batch matrix --layer-group parcel-letter,parcel-large,parcel-heavy --quiet"
Sleep 400ms
Enter
Wait@180s
Sleep 4s
