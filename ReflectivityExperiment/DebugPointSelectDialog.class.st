Class {
	#name : #DebugPointSelectDialog,
	#superclass : #SpSelectDialog,
	#instVars : [
		'code'
	],
	#category : #ReflectivityExperiment
}

{ #category : #initialization }
DebugPointSelectDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: label expand: false;
	   add: (SpPanedLayout newTopToBottom
			add: list;
			add: code;
			yourself);
		yourself
]

{ #category : #initialization }
DebugPointSelectDialog >> initializePresenters [ 
	label := self newLabel.

	list := DebugPointsTablePresenter new.
	code := DebugPointsCodePresenter new
		beForScripting;
		editable: false.
	list whenSelectionChangedDo: [ :dp | 
		list selectedItem ifNotNil:[
			code updateCode: list selectedItem ].
	]
]

{ #category : #initialization }
DebugPointSelectDialog >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Debug Points';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 800@400
]

{ #category : #initialization }
DebugPointSelectDialog >> items: items [
	list items: items
]
