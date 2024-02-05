"
I am the superclass of UI elements of debug point behaviors.

By setting the expand property a subclass can decide if the element should be expanding automatically when it is used in the DebugPointEditor.
"
Class {
	#name : 'DebugPointBehaviorUI',
	#superclass : 'SpPresenter',
	#instVars : [
		'behavior',
		'debugPoint',
		'checkBox'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'accessing' }
DebugPointBehaviorUI >> behavior [
	^behavior
]

{ #category : 'accessing' }
DebugPointBehaviorUI >> behavior: aBehavior [
	behavior := aBehavior 
]

{ #category : 'accessing' }
DebugPointBehaviorUI >> debugPoint [ 
	^debugPoint 
]

{ #category : 'accessing' }
DebugPointBehaviorUI >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]

{ #category : 'layout' }
DebugPointBehaviorUI >> expand [
	^false
]
