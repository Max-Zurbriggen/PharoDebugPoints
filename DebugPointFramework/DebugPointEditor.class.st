Class {
	#name : #DebugPointEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'debugPoint',
		'isActiveCheckBox',
		'actionBar',
		'onceCheckBox'
	],
	#category : #DebugPointFramework
}

{ #category : #layout }
DebugPointEditor >> createLayout [
	self layout: SpBoxLayout newTopToBottom.
	self layout add: actionBar expand: false.
	self layout add: isActiveCheckBox expand: false.
	self layout add: (ConditionUI new debugPoint: debugPoint ) expand: false .
	self layout add: onceCheckBox  expand: false.
	self layout add: debugPoint uiElement expand:false.

]

{ #category : #accessing }
DebugPointEditor >> debugPoint [
	^debugPoint
	

	
]

{ #category : #accessing }
DebugPointEditor >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint .
	
	self updateAll.
	
]

{ #category : #layout }
DebugPointEditor >> defaultLayout [ 
	^SpBoxLayout newTopToBottom
	add: (SpLabelPresenter new label: 'Select a Debug Point');
	yourself.
]

{ #category : #'as yet unclassified' }
DebugPointEditor >> initializePresenters [
	isActiveCheckBox := self newCheckBox label: 'enabled'.
	actionBar := self newActionBar
		add: (self newButton
			label: 'Refresh'; 
			icon: (self iconNamed: #smallUpdate);
			help: 'refresh page';
			action: [self layout children do: [ :c | c update]];
			yourself);
		addLast: (self newButton
			label: 'Remove'; 
			icon: (self iconNamed: #smallCancel);
			help: 'Remove this point';
			action: [ UIManager default defer: [ self inform: 'Remove' ] ];
			yourself);
		yourself.
		
	onceCheckBox := self newCheckBox label: 'once'.
]

{ #category : #accessing }
DebugPointEditor >> onceCheckBox [

	onceCheckBox state: (self debugPoint getBehavior: OnceBehavior) isNotNil.
	onceCheckBox whenActivatedDo: [ self debugPoint addBehavior: OnceBehavior new ].
	onceCheckBox whenDeactivatedDo: [ self debugPoint removeBehavior: OnceBehavior ].
]

{ #category : #accessing }
DebugPointEditor >> updateAll [

	isActiveCheckBox state: debugPoint enabled.
	isActiveCheckBox whenActivatedDo: [ debugPoint enabled: true ].
	isActiveCheckBox whenDeactivatedDo: [ debugPoint enabled: false ].
	
	self createLayout.
	"self layout children do: [ :c | c update]"
]
