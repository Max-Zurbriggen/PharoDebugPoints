Class {
	#name : #CountDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #asserting }
CountDebugPointIconStyler >> debugPointOn: aNode [
	^(aNode links detect: [ :link | link metaObject class = CountDebugPoint ]) metaObject.
]

{ #category : #asserting }
CountDebugPointIconStyler >> iconFor: aNode [
	
	^ self iconNamed: #smallDebug
]

{ #category : #defaults }
CountDebugPointIconStyler >> iconLabel: aNode [
	| counter |
	counter := (aNode links detect: [ :link | link metaObject class = CountDebugPoint ]) metaObject.
	^ 'Counter: ', counter count asString
]

{ #category : #asserting }
CountDebugPointIconStyler >> shouldStyleNode: aNode [
	^aNode hasDebugPointOfType: CountDebugPoint
]
