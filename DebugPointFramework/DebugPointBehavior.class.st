"
I am the subclass for different behaviors which can be added to all debug points.

In what orders the behaviors are executed is decided by the priority variable.
The highest value is executed first.

Condition: 50 (at the beginning)
Once: 0 (standard)

API:
execute method should return true if execution should continue and false if it should interrupt.

"
Class {
	#name : #DebugPointBehavior,
	#superclass : #Object,
	#instVars : [
		'priority',
		'debugPoint'
	],
	#category : #'DebugPointFramework-Base'
}

{ #category : #adding }
DebugPointBehavior class >> addToDebugPoint: aDebugPoint [
	aDebugPoint addBehavior: (self new debugPoint: aDebugPoint).
	^aDebugPoint 
]

{ #category : #accessing }
DebugPointBehavior >> debugPoint [
	^ debugPoint 
]

{ #category : #accessing }
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

{ #category : #cleanup }
DebugPointBehavior >> remove [
	"cleanup actions should be taken here"
	^self.
]
