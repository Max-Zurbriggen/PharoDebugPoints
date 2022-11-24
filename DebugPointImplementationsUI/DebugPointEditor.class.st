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
