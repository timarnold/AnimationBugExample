# Potential bug with `drawViewHierarchyInRect:afterScreenUpdates:`

This example project demonstrates a potential bug as described [here](http://stackoverflow.com/questions/23157653/drawviewhierarchyinrectafterscreenupdates-delays-other-animations).

To observe the bug, run the app, tap 'Animate' to observe the animation behavior. Then tap 'Generate Screens', and
tap 'Animate' again. Notice the delay that exists between tapping 'Animate' and the actual animation. 