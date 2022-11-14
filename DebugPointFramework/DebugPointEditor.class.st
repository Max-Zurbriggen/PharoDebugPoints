Class {
	#name : #DebugPointEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'debugPoint',
		'isActiveCheckBox'
	],
	#category : #DebugPointFramework
}

{ #category : #layout }
DebugPointEditor >> createLayout [
	self layout: SpBoxLayout newTopToBottom.
	self layout add: isActiveCheckBox expand: false.
	self layout add: (ConditionUI new debugPoint: debugPoint ) expand: false.
	self layout add: (OnceUI new debugPoint: debugPoint ) expand: false.
	self layout add: debugPoint uiElement .
	self layout add: (self newButton label: 'refresh'; action: [self layout children do: [ :c | c update]]).
]

{ #category : #accessing }
DebugPointEditor >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint .
	
	self updateAll.
	
]

{ #category : #layout }
DebugPointEditor >> defaultLayout [ 
	^SpBoxLayout newTopToBottom.
]

{ #category : #'as yet unclassified' }
DebugPointEditor >> initializePresenters [
	isActiveCheckBox := self newCheckBox label: 'DebugPoint enabled'.

]

{ #category : #'as yet unclassified' }
DebugPointEditor >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Debug Point Editor';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 330@600
]

{ #category : #accessing }
DebugPointEditor >> updateAll [

	isActiveCheckBox state: debugPoint enabled.
	isActiveCheckBox whenActivatedDo: [ debugPoint enabled: true ].
	isActiveCheckBox whenDeactivatedDo: [ debugPoint enabled: false ].
	
	self createLayout.
	self layout children do: [ :c | c update]
]
