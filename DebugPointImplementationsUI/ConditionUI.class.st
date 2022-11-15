Class {
	#name : #ConditionUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'codeInput',
		'checkBox'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
ConditionUI >> activate [
	| bh |
	
	bh := (ConditionBehavior new condition: codeInput text).
	self debugPoint addBehavior: bh.
	codeInput beEditable.
	self behavior: bh
]

{ #category : #layout }
ConditionUI >> deactivate [

	self debugPoint removeBehavior: ConditionBehavior.
	codeInput beNotEditable.
	self behavior: nil.
]

{ #category : #layout }
ConditionUI >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint.
	behavior := self debugPoint getBehavior: ConditionBehavior.
	checkBox state: self behavior isNotNil.
	codeInput editable: checkBox state.
	checkBox whenActivatedDo: [ self activate ].
	checkBox whenDeactivatedDo: [ self deactivate   ].
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

{ #category : #layout }
ConditionUI >> initializePresenters [ 
	
	codeInput  := self newCode.
	codeInput beForScripting.
	codeInput whenTextChangedDo: [ behavior condition: codeInput text ].
	checkBox := self newCheckBox.
	
]
