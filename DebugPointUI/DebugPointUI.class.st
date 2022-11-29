Class {
	#name : #DebugPointUI,
	#superclass : #SpPresenter,
	#instVars : [
		'behavior',
		'debugPoint'
	],
	#category : #DebugPointUI
}

{ #category : #accessing }
DebugPointUI >> behavior [
	^behavior
]

{ #category : #accessing }
DebugPointUI >> behavior: aBehavior [
	behavior := aBehavior 
]

{ #category : #accessing }
DebugPointUI >> debugPoint [ 
	^debugPoint 
]

{ #category : #accessing }
DebugPointUI >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]
