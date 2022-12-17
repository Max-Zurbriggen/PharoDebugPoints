Class {
	#name : #DebugPointBehaviorUI,
	#superclass : #SpPresenter,
	#instVars : [
		'behavior',
		'debugPoint',
		'checkBox'
	],
	#category : #DebugPointUI
}

{ #category : #accessing }
DebugPointBehaviorUI >> behavior [
	^behavior
]

{ #category : #accessing }
DebugPointBehaviorUI >> behavior: aBehavior [
	behavior := aBehavior 
]

{ #category : #accessing }
DebugPointBehaviorUI >> debugPoint [ 
	^debugPoint 
]

{ #category : #accessing }
DebugPointBehaviorUI >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]

{ #category : #accessing }
DebugPointBehaviorUI >> expand [
	^false
]
