Class {
	#name : #DebugPointUI,
	#superclass : #SpPresenter,
	#instVars : [
		'debugPoint'
	],
	#category : #DebugPointUI
}

{ #category : #accessing }
DebugPointUI >> debugPoint [ 
	^debugPoint 
]

{ #category : #accessing }
DebugPointUI >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]
