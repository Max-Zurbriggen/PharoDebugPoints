Class {
	#name : #DebugPointSelectDialog,
	#superclass : #SpSelectDialog,
	#instVars : [
		'code'
	],
	#category : #DebugPointUI
}

{ #category : #layout }
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

{ #category : #layout }
DebugPointSelectDialog >> initializePresenters [ 
	label := self newLabel.

	list := DebugPointTablePresenter new.
	code := DebugPointCodePresenter new
		beForScripting;
		editable: false.
	list whenSelectionChangedDo: [ :dp | 
		list selectedItem ifNotNil:[
			code updateCode: list selectedItem ].
	]
]

{ #category : #layout }
DebugPointSelectDialog >> initializeWindow: aWindowPresenter [ 
	
	aWindowPresenter
		title: 'Debug Points';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 800@400

]

{ #category : #layout }
DebugPointSelectDialog >> items: items [ 
	list items: items
]
