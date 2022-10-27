"
In what orders the behaviors are executed is decided by the priority variable.
The highest value is executed first.

Condition: 50 (at the beginning)
Once: 0 (standard)
Break: -100 (always at the end)
"
Class {
	#name : #DebugPointBehavior,
	#superclass : #Object,
	#instVars : [
		'priority',
		'debugPoint'
	],
	#category : #DebugPointFramework
}

{ #category : #adding }
DebugPointBehavior class >> addToDebugPoint: aDebugPoint [
	aDebugPoint addBehavior: (self new debugPoint: aDebugPoint).
	^aDebugPoint 
]

{ #category : #execution }
DebugPointBehavior >> debugPoint [
	^ debugPoint 
]

{ #category : #execution }
DebugPointBehavior >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]

{ #category : #execution }
DebugPointBehavior >> execute [
	self subclassResponsibility
]

{ #category : #accessing }
DebugPointBehavior >> getArgument: aSymbol [
	^self debugPoint getArgument: aSymbol
]

{ #category : #initialization }
DebugPointBehavior >> initialize [ 
	self priority: 0
]

{ #category : #accessing }
DebugPointBehavior >> priority [
	^priority 
]

{ #category : #accessing }
DebugPointBehavior >> priority: anInteger [
	priority := anInteger 
]

{ #category : #initialization }
DebugPointBehavior >> requiredArguments [ 
	^#()
]
