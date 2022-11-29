# PharoDebugPoints

  ```Smalltalk
Metacello new
  repository: 'github://Max-Zurbriggen/PharoDebugPoints';
    baseline: 'PharoDebugPoints';
      load.
```

# Guide

## Placement

All debug points can be placed like with previous breakpoints by right-clicking on an expression in the code editor.
(NOTE: only the submenu “Debug Points” is new, all other debugging features are already part of the image)
![Menu](https://github.com/Max-Zurbriggen/PharoDebugPoints/tree/master/pictures/debugPointMenu.png)

## Debug Point Types
- Breakpoint: 	Break when the node is reached
- Counter: 	Count how often a node is reached
- Script: 		Execute a script when the node is reached
- Transcript:	Write something to transcript when the node is reached
- Watch: 		Saves the values of the node in a history

## Debug Point Behaviors
Behaviors can be added to all types of debug points in the manager.
- Condition:	The debug point is only executed when the condition returns true
- Once:		The debug point is deactivated after being executed

## Managing Debug Points
You can manage debug points in the manager or when hovering over the icon in the code editor:
![Menu](https://github.com/Max-Zurbriggen/PharoDebugPoints/tree/master/pictures/worldMenu.png)
![Menu](https://github.com/Max-Zurbriggen/PharoDebugPoints/tree/master/pictures/iconHoverOptions.png)

The manager should be mostly self-explanatory, a debug point can be selected on the left side and edited on the right side:
![Menu](https://github.com/Max-Zurbriggen/PharoDebugPoints/tree/master/pictures/debugPointManager.png)

## Object Centric Debug Points

When inspecting an object, you can set the scope of an already existing debug point to this specific object:
![Menu](https://github.com/Max-Zurbriggen/PharoDebugPoints/tree/master/pictures/scopeButton.png)
