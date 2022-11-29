Class {
	#name : #ConditionUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'codeInput',
		'checkBox'
	],
	#category : #DebugPointUI
}

{ #category : #layout }
ConditionUI >> activate [
	| bh |
	self behavior ifNotNil: [ ^self ].
	bh := (ConditionBehavior new condition: codeInput text).
	self debugPoint addBehavior: bh.
	self behavior: bh
]

{ #category : #layout }
ConditionUI >> deactivate [

	self debugPoint removeBehavior: ConditionBehavior.
	self behavior: nil.
]

{ #category : #accessing }
ConditionUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	
	behavior := self debugPoint getBehavior: ConditionBehavior.
	checkBox state: self behavior isNotNil.
	codeInput enabled: checkBox state.
	(self behavior ifNotNil: [:bh | codeInput text: bh condition]).

]

{ #category : #layout }
ConditionUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom
		add: (checkBox label: 'Condition') expand: false;
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: codeInput expand: true ;
			yourself) height: 60;
		yourself.
]

{ #category : #initialization }
ConditionUI >> initializePresenters [ 
	
	codeInput  := self newCode.
	codeInput beForScripting.
	codeInput whenTextChangedDo: [ self behavior ifNotNil: [behavior condition: codeInput text ]].
	checkBox := self newCheckBox.
	checkBox whenActivatedDo: [ self activate ].
	checkBox whenDeactivatedDo: [ self deactivate ].
	
	
]
