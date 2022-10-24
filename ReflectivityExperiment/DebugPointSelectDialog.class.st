Class {
	#name : #DebugPointSelectDialog,
	#superclass : #SpSelectDialog,
	#category : #ReflectivityExperiment
}

{ #category : #initialization }
DebugPointSelectDialog >> debugPointContextMenu [

	^ self newMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 	anItem
					name: 'Inspect';
					description: 'Inspect this debug point';
					action: [ list selectedItem inspect ] ];
				addItem: [ :anItem | 	anItem
					name: 'Refresh';
					description: 'Refresh window';
					action: [ list refresh ] ];
				addItem: [ :anItem | 	anItem
					name: 'Browse Target';
					description: 'Browse Target';
					action: [ list selectedItem node methodNode method browse ] ];
				addItem: [ :anItem | 	anItem
					name: 'Inspect Current Scope';
					description: 'Inspect Current Scope';
					action: [ list selectedItem targetInstance inspect ] ];
				addItem: [ :anItem | 	anItem
					name: 'Remove';
					description: 'Removes this debug point';
					action: [ list selectedItem uninstall. list refresh ] ]
			] 
]

{ #category : #initialization }
DebugPointSelectDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: label expand: false;
	   add: list;
		yourself
]

{ #category : #initialization }
DebugPointSelectDialog >> initializeDebugPointTable [


	list  := self newTable.
	list beResizable.
	list 
		addColumn:
			((SpCheckBoxTableColumn
				title: ' '
				evaluated: [ :item | item enabled ])
				onActivation: [ :item | item enabled: true ];
				onDeactivation: [ :item | item enabled: false ];
				width: 20;
				yourself);
		addColumn:
			((SpStringTableColumn
				title: 'Class'
				evaluated: [ :item | item class ])
				width: 150;
				yourself);
		addColumn:
			(SpStringTableColumn
				title: 'Target'
				evaluated: [ :item | item printTargetForBreakpointInspection ]);
		addColumn:
			(SpStringTableColumn
				title: 'Scope'
				evaluated: [ :item | item targetInstance  ]);
		addColumn:
			((SpStringTableColumn
				title: 'Key'
				evaluated: [ :item | item key ])
				width: 110;
				yourself);
		contextMenu: self debugPointContextMenu.
	list items: (DebugPoint allDebugPoints  ).
	
list whenActivatedDo: [ self accept ]
]

{ #category : #initialization }
DebugPointSelectDialog >> initializePresenters [ 
	label := self newLabel.
	label label: 'test'.
	self initializeDebugPointTable.
	
]

{ #category : #initialization }
DebugPointSelectDialog >> initializeWindow: aWindowPresenter [
	
	aWindowPresenter
		title: 'Select Debug Point to Set Scope for';		
		windowIcon: (self application iconNamed: #glamorousBug);
		initialExtent: 800@400
]
