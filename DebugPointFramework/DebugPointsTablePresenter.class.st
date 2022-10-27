Class {
	#name : #DebugPointsTablePresenter,
	#superclass : #SpTablePresenter,
	#category : #DebugPointFramework
}

{ #category : #initialization }
DebugPointsTablePresenter >> debugPointContextMenu [
	^ self newMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 	anItem
					name: 'Inspect';
					description: 'inspect this debug point';
					enabled: [ self selectedItem isNotNil ];
					action: [ self selectedItem inspect ] ];	
				addItem: [ :anItem | 	anItem
					name: 'Remove';
					description: 'removes the selected debug point';
					enabled: [ self selectedItem isNotNil ];
					action: [ self selectedItem uninstall. self refresh ] ]
			];
		addGroup: [ :aGroup | 
			aGroup 
				addItem: [ :anItem | 	anItem
					name: 'Refresh';
					description: 'refresh this window';
					action: [ self refresh ] ]
				]
]

{ #category : #initialization }
DebugPointsTablePresenter >> initialize [ 
	super initialize.
	self initializeDebugPointTable 
]

{ #category : #initialization }
DebugPointsTablePresenter >> initializeDebugPointTable [

	self beResizable.
	self 
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
				title: 'Behaviors'
				evaluated: [ :item | item behaviors ])
				width: 150;
				yourself);
		contextMenu: self debugPointContextMenu.
	self items: (DebugPoint all asOrderedCollection ).
]
