Class {
	#name : #DebugPointEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'debugPoint'
	],
	#category : #DebugPointFramework
}

{ #category : #layout }
DebugPointEditor >> createLayout [
	self layout: SpBoxLayout newTopToBottom.
	debugPoint  behaviors do: [ :bh | self layout add: bh uiElement expand: false  ].
	self layout add: (self newButton label: 'refresh'; action: [self layout children do: [ :c | c update]]).
]

{ #category : #accessing }
DebugPointEditor >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint .
	self createLayout.
	self layout children do: [ :c | c update]
	
]

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
