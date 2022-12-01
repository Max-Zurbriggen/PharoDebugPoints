Class {
	#name : #TranscriptDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #defaults }
TranscriptDebugPointIconStyler >> forClass [
	^TranscriptDebugPoint 
]

{ #category : #asserting }
TranscriptDebugPointIconStyler >> icon [
	
	^ self iconNamed: #transcript
]

{ #category : #defaults }
TranscriptDebugPointIconStyler >> iconLabel: aNode [
	| debugPoint |
	debugPoint := (aNode links detect: [ :link | link metaObject class = self forClass ]) metaObject.
	^ 'Transcript ("', debugPoint text,'")'
]
