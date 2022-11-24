Class {
	#name : #DebugPointEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'debugPoint',
		'isActiveCheckBox',
		'actionBar'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
DebugPointEditor >> createLayout [

	self debugPoint ifNil: [ ^self layout: self defaultLayout ].
	
	self layout: SpBoxLayout newTopToBottom.
	self layout add: actionBar expand: false.
	self layout add: isActiveCheckBox expand: false.
	isActiveCheckBox state: self debugPoint enabled.
	DebugPointBehavior allSubclassesDo: [ :behavior |
		 self layout add: (behavior uiElement new debugPoint: self debugPoint ) expand: false .
		]. 
	"self layout add: (ConditionUI new debugPoint: debugPoint ) expand: false .
	self layout add: (OnceUI new debugPoint: debugPoint )  expand: false."
	self layout add: debugPoint uiElement.

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
	^SpBoxLayout new hAlignCenter; vAlignCenter;
	add: (SpLabelPresenter new label: 'Select a Debug Point');
	yourself.
]

{ #category : #initialization }
DebugPointEditor >> initializePresenters [
	isActiveCheckBox := self newCheckBox label: 'enabled'.
	isActiveCheckBox whenActivatedDo: [ debugPoint enabled: true ].
	isActiveCheckBox whenDeactivatedDo: [ debugPoint enabled: false ].
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

{ #category : #update }
DebugPointEditor >> updateAll [

	self createLayout.
	self layout children do: [ :c | c update]
]
