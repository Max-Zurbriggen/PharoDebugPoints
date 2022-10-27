Class {
	#name : #DebugPointTreeTablePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'table1'
	],
	#category : #DebugPointFramework
}

{ #category : #accessing }
DebugPointTreeTablePresenter >> debugPointContextMenu [
	^ self newMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 	anItem
					name: 'Inspect';
					description: 'inspect this debug point';
					enabled: [ table1 selectedItem isNotNil ];
					action: [ table1 selectedItem inspect ] ];	
				addItem: [ :anItem | 	anItem
					name: 'Remove';
					description: 'removes the selected debug point';
					enabled: [ table1 selectedItem isNotNil ];
					action: [ table1 selectedItem uninstall. table1 refresh ] ]
			];
		addGroup: [ :aGroup | 
			aGroup 
				addItem: [ :anItem | 	anItem
					name: 'Refresh';
					description: 'refresh this window';
					action: [ table1 refresh ] ]
				]
]

{ #category : #layout }
DebugPointTreeTablePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: table1;
		add: 'Double click to inspect.' expand: false;
		yourself
]

{ #category : #initialization }
DebugPointTreeTablePresenter >> initializePresenters [

	table1 := self newTreeTable.
	table1
		addColumn: (SpCompositeTableColumn new
			title: 'DebugPoints';
			"addColumn: ((SpCheckBoxTableColumn 
				evaluated: [ :dp | 
					dp class = DebugPoint ifTrue: [dp enabled ] ifFalse: [true]])
				width: 20;
				enabled: false;
				yourself);"
			addColumn: (SpStringTableColumn evaluated: [ :aClass | aClass class ]);
			yourself);
		roots: (DebugPoint all asOrderedCollection );
		children: [ :aClass | aClass class = DebugPoint ifTrue: [aClass behaviors] ifFalse: [ #() ] ];
		beResizable;
		contextMenu: self debugPointContextMenu;
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem inspect ];
		expandAll.
]