Class {
	#name : #CountDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #asserting }
CountDebugPointIconStyler >> forClass [
	^CountDebugPoint 
]

{ #category : #asserting }
CountDebugPointIconStyler >> icon [
	
	^ self iconNamed: #smallDebug
]

{ #category : #defaults }
CountDebugPointIconStyler >> iconLabel: aNode [
	| counter |
	counter := (aNode links detect: [ :link | link metaObject class = CountDebugPoint ]) metaObject.
	^ 'Counter: ', counter count asString
]
