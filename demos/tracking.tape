# The companion to the parcel matrix: the same mechanism over Shippo's six deterministic tracking
# fixtures. Nothing is bought, nothing is created, the answers never move, and the whole thing is
# over in about ten seconds — including the dedup list, where the plan that pins its own tracking
# number collapses all six layers into one run.
#
# Writes demos/out/demo-tracking.gif.

Output demos/out/demo-tracking.gif

Require aat

Set Shell "bash"
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrains Mono"
Set FontSize 13
Set Width 1180
Set Height 820
Set Padding 20
Set Framerate 24
Set TypingSpeed 30ms
Set CursorBlink false

Hide
Type "clear"
Enter
Wait
Show

Sleep 500ms
Type "aat run batch tracking --layer-group track-pre-transit,track-transit,track-delivered,track-returned,track-failure,track-unknown"
Sleep 400ms
Enter
Wait@120s
Sleep 4s
