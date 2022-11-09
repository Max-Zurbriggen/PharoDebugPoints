Class {
	#name : #BehaviorUI,
	#superclass : #SpPresenter,
	#instVars : [
		'behavior'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #accessing }
BehaviorUI >> behavior [
	^behavior
]

{ #category : #accessing }
BehaviorUI >> behavior: aBehavior [
	behavior := aBehavior 
]
