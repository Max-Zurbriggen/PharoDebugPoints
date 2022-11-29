"
I am a debug point that has a counter that increases when hit.
"
Class {
	#name : #CountDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'count'
	],
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #execution }
CountDebugPoint >> count [
	^count ifNil: [ count := 0 ].
]

{ #category : #execution }
CountDebugPoint >> count: anInteger [
	count:= anInteger 
]

{ #category : #API }
CountDebugPoint >> hitWithContext: aContext [
	
	(super hitWithContext: aContext) ifFalse: [^self].
	
	self increaseCount.
	DebugPointManager notifyDebugPointChanged: self.
]

{ #category : #execution }
CountDebugPoint >> increaseCount [
	self count: self count + 1.
	
]

{ #category : #execution }
CountDebugPoint >> name [
	^#Counter
]

{ #category : #'ui building' }
CountDebugPoint >> uiElement [ 
	^CountUI new debugPoint: self.
]
