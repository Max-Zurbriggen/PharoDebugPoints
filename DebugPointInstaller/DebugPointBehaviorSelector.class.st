Class {
	#name : #DebugPointBehaviorSelector,
	#superclass : #SpDialogPresenter,
	#instVars : [
		'label',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel',
		'list',
		'selection'
	],
	#category : #DebugPointInstaller
}

{ #category : #accessing }
DebugPointBehaviorSelector class >> defaultExtent [

	^ 450@300
]

{ #category : #layout }
DebugPointBehaviorSelector class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #list;
		yourself
]

{ #category : #documentation }
DebugPointBehaviorSelector class >> documentFactoryMethodSelector [
	
	^ #newSelect
]

{ #category : #examples }
DebugPointBehaviorSelector class >> example [

	self new
		title: 'Select example';
		label: 'Select a class';
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | each systemIcon ];
		onAccept: [ :dialog | self inform: dialog presenter selectedItem asString ];
		openDialog
]

{ #category : #examples }
DebugPointBehaviorSelector class >> exampleModal [
	| selection |

	selection := self new
		title: 'Select modal example';
		label: 'Select a class';
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | each systemIcon ];
		openModal.
		
	selection ifNotNil: [ 
		self inform: selection asString ]
]

{ #category : #api }
DebugPointBehaviorSelector >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #api }
DebugPointBehaviorSelector >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #api }
DebugPointBehaviorSelector >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #api }
DebugPointBehaviorSelector >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #api }
DebugPointBehaviorSelector >> display: aBlock [

	list display: aBlock
]

{ #category : #api }
DebugPointBehaviorSelector >> displayIcon: aBlock [

	list displayIcon: aBlock
]

{ #category : #api }
DebugPointBehaviorSelector >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #api }
DebugPointBehaviorSelector >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
DebugPointBehaviorSelector >> initialize [
	
	super initialize.
	selection := OrderedCollection new.
	self title: 'Request'
]

{ #category : #initialization }
DebugPointBehaviorSelector >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | self cancel ];
		addDefaultButton: self acceptLabel do: [ :presenter | self accept ]
]

{ #category : #initialization }
DebugPointBehaviorSelector >> initializePresenters [

	label := self newLabel.
	list := self newTable.
	
	"list addStyle: 'spSelectList'."
	"list whenActivatedDo: [ self accept ]"
	list beResizable;
		addColumn: 
			((SpCheckBoxTableColumn
				title: ' '
				evaluated: [ false ])
				onActivation: [ :bh | selection add: bh];
				onDeactivation: [ :bh | selection remove: bh];
				width: 20;
				yourself);
		addColumn:
			((SpStringTableColumn
				title: 'Behaviors'
				evaluated: [ :item | item ])
				yourself);
		items: BreakBehavior package classes asOrderedCollection.
]

{ #category : #initialization }
DebugPointBehaviorSelector >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ list takeKeyboardFocus ]
]

{ #category : #api }
DebugPointBehaviorSelector >> items [

	^ list items
]

{ #category : #api }
DebugPointBehaviorSelector >> items: aCollection [

	list items: aCollection
]

{ #category : #api }
DebugPointBehaviorSelector >> label: aString [

	label label: aString
]

{ #category : #'api - showing' }
DebugPointBehaviorSelector >> openModal [
	| dialog |
	
	dialog := super openModal.
	^ dialog isOk
		ifTrue: [ selection ]
		ifFalse: [ ]
]

{ #category : #api }
DebugPointBehaviorSelector >> selectedItem [

	^ list selectedItem
]

{ #category : #api }
DebugPointBehaviorSelector >> title [

	^ title
]

{ #category : #api }
DebugPointBehaviorSelector >> title: aString [

	title := aString
]
