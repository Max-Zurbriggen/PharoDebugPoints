# PharoDebugPoints

Imagine breakpoints that do something else than breaking. We named these points debug points. This repository adds debug points that can be placed in your code for easier debugging, and the tools to use them. There are a couple of behaviors most of which can be added to any type of debug point. You can add this repository to your image with the followng command:

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

![Menu](/pictures/debugPointMenuV2.png)

## Debug Point Behaviors
With the exception of Break and Watch all of the behaviors below can be added and combined in any debug point in the manager.

- Break: 	Break when the node is reached
- Condition:	The debug point is only executed when the condition returns true.
- Once:		The debug point is deactivated after being executed.
- Count: 	Count how often a debug point is executed.
- Watch: 		Saves the values of the node in a history
- Script: 		Execute a script when the node is reached
- Transcript:	Write something to transcript when the node is reached
- Test Environment Only: The other behaviors of the debug point will only be executed when the method is called in the context of a test.
- Chain:  When the parent debug point is executed it activates the child debug point while deactivating itself. A debug point can be added as a child by drag and dropping it on the desired parent in the debug point manager in the list on the left side.

## Managing Debug Points
You can manage debug points in the manager or when hovering over the icon in the code editor:

![Menu](/pictures/worldMenu.png)
![Menu](/pictures/iconHoverOptions.png)

The manager should be mostly self-explanatory, a debug point can be selected on the left side and edited on the right side:

![Menu](/pictures/managerWithChain.png)

## Object Centric Debug Points
Sometimes you only want to execute the behaviors of a debug point when a specific object calls a method. By setting the scope of a debug point to an object this can be achieved.
When inspecting an object, you can set the scope of an already existing debug point to this specific object:

![Menu](/pictures/scopeButton.png)
