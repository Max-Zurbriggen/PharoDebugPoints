Class {
	#name : #OnceBehavior,
	#superclass : #DebugPointBehavior,
	#category : #DebugPointBehaviors
}

{ #category : #execution }
OnceBehavior >> execute [
	self debugPoint enabled: false.
]

{ #category : #accessing }
OnceBehavior >> uiElement [ 
	^SpLabelPresenter new label: 'Once'.
]
