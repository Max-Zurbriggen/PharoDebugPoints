Class {
	#name : #CountDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'count'
	],
	#category : #DebugPointImplementations
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
	
	super hitWithContext: aContext.
	
	self increaseCount.
]

{ #category : #execution }
CountDebugPoint >> increaseCount [
	self count: self count + 1.
]

{ #category : #accessing }
CountDebugPoint >> uiElement [ 
	^CountUI new behavior: self.
]
