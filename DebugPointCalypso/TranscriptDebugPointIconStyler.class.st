Class {
	#name : #TranscriptDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #asserting }
TranscriptDebugPointIconStyler >> debugPointOn: aNode [
	^(aNode links detect: [ :link | link metaObject class = TranscriptDebugPoint ]) metaObject.
]

{ #category : #asserting }
TranscriptDebugPointIconStyler >> iconFor: aNode [
	
	^ self iconNamed: #smallDebug
]

{ #category : #defaults }
TranscriptDebugPointIconStyler >> iconLabel: aNode [
	| debugPoint |
	debugPoint := (aNode links detect: [ :link | link metaObject class = TranscriptDebugPoint ]) metaObject.
	^ 'Transcript ("', debugPoint text,'")'
]

{ #category : #asserting }
TranscriptDebugPointIconStyler >> shouldStyleNode: aNode [
	^aNode hasDebugPointOfType: TranscriptDebugPoint
]
