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
BreakDebugPointIconStyler >> icon [
	
	^ self iconNamed: #smallError
]
