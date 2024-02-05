"
I am the superclass for UI elements for subclasses of DebugPoint.
"
Class {
	#name : 'DebugPointUI',
	#superclass : 'SpPresenter',
	#instVars : [
		'debugPoint'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'accessing' }
DebugPointUI >> debugPoint [ 
	^debugPoint 
]

{ #category : 'accessing' }
DebugPointUI >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]
