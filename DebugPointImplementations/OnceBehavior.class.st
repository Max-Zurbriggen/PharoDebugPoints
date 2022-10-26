Class {
	#name : #OnceBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'debugPoint'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
OnceBehavior >> debugPoint [
	^ debugPoint 
]

{ #category : #execution }
OnceBehavior >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]

{ #category : #execution }
OnceBehavior >> execute [
	self debugPoint enabled: false.
]
