Class {
	#name : #DebugPointIconStyler,
	#superclass : #IconStyler,
	#category : #DebugPointCalypso
}

{ #category : #'as yet unclassified' }
DebugPointIconStyler >> debugPointOn: aNode [
	^(aNode links detect: [ :link | link metaObject isKindOf: DebugPoint ]) metaObject.
]

{ #category : #defaults }
DebugPointIconStyler >> highlightColor [
	^(Color yellow alpha: 0.3)
]

{ #category : #defaults }
DebugPointIconStyler >> iconBlock: aNode [

	 ^ [ :seg | DebugPointManager new open; select: (self debugPointOn: aNode). self halt.
	   "aNode breakpoints do: [ :breakpoint | breakpoint remove ].
	   seg delete" ]
]

{ #category : #defaults }
DebugPointIconStyler >> iconFor: aNode [
	
	^ self iconNamed: #smallDebug
]

{ #category : #defaults }
DebugPointIconStyler >> iconLabel: aNode [
	^ 'DebugPoint'
]

{ #category : #testing }
DebugPointIconStyler >> shouldStyleNode: aNode [
	^self subclassResponsibility 
]
