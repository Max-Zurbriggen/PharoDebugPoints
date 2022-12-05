Class {
	#name : #CountBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'count'
	],
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #'ui building' }
CountBehavior class >> uiElement [

	^ CountUI 
]

{ #category : #execution }
CountBehavior >> count [
	^count ifNil: [ count := 0 ].
]

{ #category : #execution }
CountBehavior >> count: anInteger [
	count:= anInteger 
]

{ #category : #execution }
CountBehavior >> increaseCount [
	self count: self count + 1.
	
]
