"
I create a horizontal list of UI elements, based on the behaviors and class of a DebugPoint.
"
Class {
	#name : 'DebugPointEditor',
	#superclass : 'SpPresenter',
	#instVars : [
		'debugPoint',
		'isActiveCheckBox',
		'actionBar'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'initialization' }
DebugPointEditor >> changeDebugPointState: newState [
	self debugPoint enabled: newState.
	DebugPointManager notifyDebugPointChanged: self debugPoint .
]

{ #category : 'layout' }
DebugPointEditor >> createLayout [

	self debugPoint ifNil: [ ^self layout: self defaultLayout ].
	self layout: SpBoxLayout newTopToBottom.
	self layout add: actionBar expand: false.
	self layout add: self newActiveCheckBox expand: false.
	DebugPointBehavior allSubclassesDo: [ :behavior |
		| behaviorUI | 
		behaviorUI := (behavior uiElement new debugPoint: self debugPoint ).
		 self layout add: behaviorUI expand: ((self debugPoint getBehavior: behavior) ifNotNil: [ behaviorUI expand ] ifNil: [ false ] ) .
		]. 
	debugPoint uiElement ifNotNil: [ :ui | self layout add: ui ].
	"self layout add: debugPoint uiElement."

]

{ #category : 'accessing' }
DebugPointEditor >> debugPoint [
	^debugPoint
	

	
]

{ #category : 'accessing' }
DebugPointEditor >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint .
	
	self updateAll.
	
]

{ #category : 'layout' }
DebugPointEditor >> defaultLayout [ 
	^SpBoxLayout new hAlignCenter; vAlignCenter;
	add: (SpLabelPresenter new label: 'Select a Debug Point');
	yourself.
]

{ #category : 'initialization' }
DebugPointEditor >> initializePresenters [
	
	actionBar := self newActionBar
		add: (self newButton
			label: 'Refresh'; 
			icon: (self iconNamed: #smallUpdate);
			help: 'refresh page';
			action: [self updateAll ];
			yourself);
		addLast: (self newButton
			label: 'Remove'; 
			icon: (self iconNamed: #smallCancel);
			help: 'Remove this point';
			action: [ debugPoint remove. ];
			yourself);
		yourself.
		
]

{ #category : 'layout' }
DebugPointEditor >> newActiveCheckBox [
	isActiveCheckBox := self newCheckBox label: 'enabled'.
	isActiveCheckBox state: self debugPoint enabled.
	isActiveCheckBox whenActivatedDo: [ self changeDebugPointState: true ].
	isActiveCheckBox whenDeactivatedDo: [ self changeDebugPointState: false ].
	^isActiveCheckBox 
]

{ #category : 'update' }
DebugPointEditor >> updateAll [

	self createLayout.
	"self layout children do: [ :c | c update]"
]
