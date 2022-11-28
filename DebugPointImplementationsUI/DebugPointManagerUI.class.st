Class {
	#name : #DebugPointManagerUI,
	#superclass : #SpPresenter,
	#instVars : [
		'dpTable',
		'dpEditor'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
DebugPointManagerUI >> defaultLayout [ 
	^SpPanedLayout newLeftToRight 
		add: dpTable;
		add: dpEditor;
		positionOfSlider:40percent;
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
	
	
]

{ #category : #initialization }
DebugPointManagerUI >> initializeTable [
	dpTable := SpTablePresenter new
	items: ( DebugPoint all asOrderedCollection );
	addColumn: (SpCompositeTableColumn new
			title: 'DebugPoints';
			addColumn: (SpCheckBoxTableColumn new 
				onActivation:  [ :dp | dp enabled: true ];
				onDeactivation: [ :dp | dp enabled: false];
				evaluated: [ :dp | dp enabled ]);
			addColumn: (SpStringTableColumn evaluated: [ :dp | dp name ]);
			yourself);
	addColumn: (SpStringTableColumn new 
		title: 'Class and Method'; 
		evaluated: [ :dp | dp node methodNode method printString]);
	
	"contextMenu: self debugPointContextMenu;"
	activateOnDoubleClick;
	beResizable ;
	whenActivatedDo: [ :selection | selection selectedItem inspect ].
	
	dpTable whenSelectionChangedDo: [ :sel | dpEditor debugPoint: dpTable selectedItem ].
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
