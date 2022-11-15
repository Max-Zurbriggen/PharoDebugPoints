Class {
	#name : #DebugPointManager,
	#superclass : #SpPresenter,
	#instVars : [
		'dpTable',
		'dpEditor'
	],
	#category : #DebugPointFramework
}

{ #category : #layout }
DebugPointManager >> defaultLayout [ 
	^SpPanedLayout newLeftToRight 
		add: dpTable;
		add: dpEditor;
		yourself.
		
]

{ #category : #initialization }
DebugPointManager >> initializePresenters [ 
	dpTable := SpTreeTablePresenter new.
	dpEditor := DebugPointEditor new.
	dpTable roots: (DebugPoint all asOrderedCollection ).
	dpTable whenSelectionChangedDo: [ :sel | dpEditor debugPoint: dpTable selectedItem ]
]

{ #category : #initialization }
DebugPointManager >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Debug Point Manager';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 430@500
]
