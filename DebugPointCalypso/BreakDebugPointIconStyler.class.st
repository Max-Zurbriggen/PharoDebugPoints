Class {
	#name : #BreakDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #'as yet unclassified' }
BreakDebugPointIconStyler >> debugPointOn: aNode [
	^(aNode links detect: [ :link | link metaObject class = BreakDebugPoint ]) metaObject.
]

{ #category : #asserting }
BreakDebugPointIconStyler >> iconFor: aNode [
	
	^ self iconNamed: #smallError
]

{ #category : #defaults }
BreakDebugPointIconStyler >> iconLabel: aNode [
	^ 'Breakpoint'
]

{ #category : #asserting }
BreakDebugPointIconStyler >> shouldStyleNode: aNode [
	^aNode hasDebugPointOfType: BreakDebugPoint
]
