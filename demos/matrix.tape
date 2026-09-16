# The matrix recording: one plan file per lane, crossed with every parcel.
#
# --parallel 4 is the point, not an optimisation. It switches on the multi-line progress renderer,
# so four runs fill their bars at once and completed runs scroll up past them — which is the thing
# worth watching. Sequential would append the same information as a wall of step lines and never
# draw a bar.
#
# --env test-ci is what makes it watchable: unpaced, eight runs are over in two seconds and the
# bars flash past. The 1.2s spacing is also what keeps a parallel batch inside Shippo's test-mode
# limit of ten list reads a minute.
#
# Writes demos/out/demo-matrix.gif.

Output demos/out/demo-matrix.gif

Require aat

Set Shell "bash"
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrains Mono"
Set FontSize 13
Set Width 1180
Set Height 560
Set Padding 20
Set Framerate 24
Set TypingSpeed 25ms
Set CursorBlink false

Hide
Type "clear"
Enter
Wait
Show

Sleep 500ms
Type "aat run batch matrix --env test-ci --layer-group parcel-letter,parcel-large,parcel-heavy --parallel 4"
Sleep 400ms
Enter
Wait@300s
Sleep 4s
