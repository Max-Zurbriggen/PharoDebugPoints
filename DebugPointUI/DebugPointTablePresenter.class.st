Class {
	#name : #DebugPointTablePresenter,
	#superclass : #SpTablePresenter,
	#instVars : [
		'code'
	],
	#category : #DebugPointUI
}

{ #category : #'as yet unclassified' }
DebugPointTablePresenter >> debugPointContextMenu [ 
	^ self newMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 	anItem
					name: 'Inspect';
					description: 'inspect this debug point';
					enabled: [ self selectedItem isNotNil ];
					action: [ self selectedItem inspect ] ];
				addItem: [ :anItem | 	anItem
					name: 'Browse Target';
					description: 'browse target of the selected debug point';
					enabled: [ self selectedItem isNotNil ];
					action: [ self selectedItem node methodNode method browse ] ];
				addItem: [ :anItem | 	anItem
					name: 'Inspect Current Scope';
					description: 'inspect the current scope of the selected debug point';
					enabled: [ self selectedItem isNotNil ];
					action: [ self selectedItem targetInstance inspect ] ];
				addItem: [ :anItem | 	anItem
					name: 'Reset Current Scope';
					description: 'resetting the current scope of the selected debug point';
					enabled: [ self selectedItem isNotNil ];
					action: [ self selectedItem resetObjectScope ] ];				
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

{ #category : #'as yet unclassified' }
DebugPointTablePresenter >> initialize [ 
	super initialize.
	self initializeDebugPointTable 
]

{ #category : #'as yet unclassified' }
DebugPointTablePresenter >> initializeDebugPointTable [ 

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
				title: 'Type'
				evaluated: [ :item | item name ])
				width: 80;
				yourself);
		addColumn:
			((SpStringTableColumn
				title: 'Target'
				evaluated: [ :item | item node methodNode  method printString ])
				width: 180;
				yourself);
		addColumn:
			(SpStringTableColumn
				title: 'Scope'
				evaluated: [ :item | item targetInstance  ]);

		contextMenu: self debugPointContextMenu.
	self items: (DebugPoint all asOrderedCollection  ). 
]