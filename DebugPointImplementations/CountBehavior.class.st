Class {
	#name : #CountBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'count'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
CountBehavior >> count [
	^count ifNil: [ count := 0 ].
]

{ #category : #execution }
CountBehavior >> count: anInteger [
	count:= anInteger 
]

{ #category : #execution }
CountBehavior >> execute [
	self increaseCount.
]

{ #category : #execution }
CountBehavior >> increaseCount [
	self count: self count + 1.
]

{ #category : #accessing }
CountBehavior >> uiElement [ 
	^CountUI new behavior: self.
]
