Class {
	#name : #OnceBehavior,
	#superclass : #DebugPointBehavior,
	#category : #DebugPointBehaviors
}

{ #category : #accessing }
OnceBehavior class >> uiElement [

	^OnceUI
]

{ #category : #execution }
OnceBehavior >> execute [
	self debugPoint enabled: false.
	^true.
]
