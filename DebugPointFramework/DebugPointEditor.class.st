Class {
	#name : #DebugPointEditor,
	#superclass : #SpPresenter,
	#category : #DebugPointFramework
}

{ #category : #layout }
DebugPointEditor >> defaultLayout [ 
	^SpBoxLayout newTopToBottom.
]

{ #category : #'as yet unclassified' }
DebugPointEditor >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Debug Point Editor';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 330@600
]
