Class {
	#name : #OnceBehavior,
	#superclass : #DebugPointBehavior,
	#category : #DebugPointImplementations
}

{ #category : #execution }
OnceBehavior >> execute [
	self debugPoint enabled: false.
]

{ #category : #accessing }
OnceBehavior >> uiElement [ 
	^SpLabelPresenter new label: 'Once'.
]
