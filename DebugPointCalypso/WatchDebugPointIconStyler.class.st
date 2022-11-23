Class {
	#name : #WatchDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #asserting }
WatchDebugPointIconStyler >> forClass [
	^WatchDebugPoint 
]

{ #category : #asserting }
WatchDebugPointIconStyler >> iconFor: aNode [
	
	^ self iconNamed: #smallDebug
]

{ #category : #defaults }
WatchDebugPointIconStyler >> iconLabel: aNode [
	| debugPoint |
	debugPoint := (aNode links detect: [ :link | link metaObject class = WatchDebugPoint ]) metaObject.
	
	^ 'Watcher (last value:"', (debugPoint history at: 1 ifAbsent: '') asString, '")'
]