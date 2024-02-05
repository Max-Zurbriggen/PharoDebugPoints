"
I am a select dialog to display DebugPoints so that the scope of a DebugPoint can be set to a specific object.
"
Class {
	#name : 'DebugPointSelectDialog',
	#superclass : 'SpSelectDialog',
	#instVars : [
		'code',
		'scope'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'layout' }
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

{ #category : 'initialization' }
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

{ #category : 'initialization' }
DebugPointSelectDialog >> initializeWindow: aWindowPresenter [ 
	
	aWindowPresenter
		title: 'Debug Points';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 800@400

]

{ #category : 'api' }
DebugPointSelectDialog >> items: items [ 
	"filter debug points such that only those that are attached to the class of the inspected object are displayed"
	list items: (items select: [ :db | db method methodClass = self scope ])
]

{ #category : 'accessing' }
DebugPointSelectDialog >> scope [  
	^scope
]

{ #category : 'accessing' }
DebugPointSelectDialog >> scope: anObject [ 
"see items: method"
	scope := anObject class
]
