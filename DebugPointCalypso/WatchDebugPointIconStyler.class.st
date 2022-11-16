Class {
	#name : #WatchDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #asserting }
WatchDebugPointIconStyler >> debugPointOn: aNode [
	^(aNode links detect: [ :link | link metaObject class = WatchDebugPoint ]) metaObject.
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

{ #category : #asserting }
WatchDebugPointIconStyler >> shouldStyleNode: aNode [
	^aNode hasDebugPointOfType: WatchDebugPoint
]
