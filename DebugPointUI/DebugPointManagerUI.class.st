Class {
	#name : #DebugPointManagerUI,
	#superclass : #SpPresenter,
	#instVars : [
		'dpTable',
		'dpEditor',
		'dpCode'
	],
	#category : #DebugPointUI
}

{ #category : #'world menu' }
DebugPointManagerUI class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #'Debug Point Manager')
		parent: #Debug;
		action: [ self new open ];
		order: -3;
		help: 'for more information contact max.zurbriggen@uzh.ch';
		icon: (self iconNamed: #glamorousBug).
	aBuilder withSeparatorAfter
]

{ #category : #layout }
DebugPointManagerUI >> defaultLayout [ 
	^SpPanedLayout newTopToBottom 
		add: (SpPanedLayout newLeftToRight 
		add: dpTable;
		add: dpEditor;
		positionOfSlider:50percent;
		yourself);
		add: dpCode;
		positionOfSlider:70percent;
		yourself.
		
		
]

{ #category : #initialization }
DebugPointManagerUI >> initialize [ 

	super initialize.
	SystemAnnouncer uniqueInstance weak when: DebugPointAdded send: #updateTable to: self.
	SystemAnnouncer uniqueInstance weak when: DebugPointRemoved send: #updateTable to: self.
	SystemAnnouncer uniqueInstance weak when: DebugPointChanged send: #updateEditor to: self.
		
	
]

{ #category : #initialization }
DebugPointManagerUI >> initializePresenters [ 

	self initializeTable.
	dpEditor := DebugPointEditor new.
	dpCode := DebugPointCodePresenter new editable: false.
	
	
]

{ #category : #initialization }
DebugPointManagerUI >> initializeTable [
	dpTable := DebugPointTablePresenter new.
	
	dpTable whenSelectionChangedDo: [ :sel | 
		dpEditor debugPoint: dpTable selectedItem.
		dpCode updateCode: dpTable selectedItem ].
]

{ #category : #initialization }
DebugPointManagerUI >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Debug Point Manager';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 800@450
]

{ #category : #enumerating }
DebugPointManagerUI >> select: aDebugPoint [
	dpTable selectItem: aDebugPoint 
]

{ #category : #initialization }
DebugPointManagerUI >> updateEditor [
	dpTable refresh.
	dpEditor updateAll .

	
]

{ #category : #initialization }
DebugPointManagerUI >> updateTable [
	| prevSel |
	prevSel := dpTable selectedItem.
	dpTable items: DebugPoint all asOrderedCollection .
	dpTable selectItem: prevSel.

	
]
