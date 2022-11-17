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
		positionOfSlider:40percent;
		yourself.
		
]

{ #category : #initialization }
DebugPointManager >> initializePresenters [ 
	"self initializeTreeTable."
	self initializeTable.
	dpEditor := DebugPointEditor new.
	
	
]

{ #category : #initialization }
DebugPointManager >> initializeTable [
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

{ #category : #deprecated }
DebugPointManager >> initializeTreeTable [
"TBD"
"this was an idea to have a list with classes seperated but i don't think its intended to be used that way because it needs a lot of workarounds"
	dpTable := SpTreePresenter new 

	roots: {'Breakpoint'. 'Watcher'. 'Script'.'Transcript'.'Counter'.'Debugpoint'} ;
	display: [ :ele | (ele isKindOf: DebugPoint) ifFalse: [ele,'s'] ifTrue: [ele asString]];
	children: [ :atype | DebugPoint all asOrderedCollection select: [ :dp | dp name = atype ] ];
	beResizable;
	"contextMenu: self debugPointContextMenu;"
	activateOnDoubleClick;
	whenActivatedDo: [ :selection | selection selectedItem inspect ];
	expandAll.
	dpTable whenSelectionChangedDo: [ :sel | dpEditor debugPoint: dpTable selectedItem ].
]

{ #category : #initialization }
DebugPointManager >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Debug Point Manager';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 800@450
]

{ #category : #enumerating }
DebugPointManager >> select: aDebugPoint [
	dpTable selectItem: aDebugPoint 
]
