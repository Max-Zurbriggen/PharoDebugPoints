Class {
	#name : #BreakDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #asserting }
BreakDebugPointIconStyler >> forClass [
	^BreakDebugPoint
]

{ #category : #asserting }
BreakDebugPointIconStyler >> iconFor: aNode [
	
	^ self iconNamed: #smallError
]

{ #category : #defaults }
BreakDebugPointIconStyler >> iconLabel: aNode [
	^ 'Breakpoint'
]
