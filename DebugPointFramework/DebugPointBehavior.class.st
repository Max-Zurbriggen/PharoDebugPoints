"
In what orders the behaviors are executed is decided by the priority variable.
The highest value is executed first.


Once: 50 (standard)
Break: -100 (always at the end)
"
Class {
	#name : #DebugPointBehavior,
	#superclass : #Object,
	#instVars : [
		'priority'
	],
	#category : #DebugPointFramework
}

{ #category : #execution }
DebugPointBehavior >> execute [
	self subclassResponsibility
]

{ #category : #initialization }
DebugPointBehavior >> initialize [ 
	self priority: 50
]

{ #category : #accessing }
DebugPointBehavior >> priority [
	^priority 
]

{ #category : #accessing }
DebugPointBehavior >> priority: anInteger [
	priority := anInteger 
]
