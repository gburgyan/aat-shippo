# The hero recording: rate a shipment, buy the label, and refund it.
# Run by demos/run.sh, which puts aat on PATH and exports SHIPPO_API_TOKEN.
# Writes demos/out/demo-label.gif.

Output demos/out/demo-label.gif

Require aat

Set Shell "bash"
Set Theme "Catppuccin Mocha"
Set FontFamily "JetBrains Mono"
Set FontSize 15
Set Width 1180
Set Height 860
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
Type "aat run plan labels/buy-and-refund"
Sleep 400ms
Enter
Wait@90s
Sleep 4s
