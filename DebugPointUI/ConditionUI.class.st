"
I am the UI element for the ConditionBehavior of DebugPoints and am added to the DebugPointEditor.
"
Class {
	#name : 'ConditionUI',
	#superclass : 'DebugPointBehaviorUI',
	#instVars : [
		'codeInput'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'layout' }
ConditionUI >> activate [
	| bh |
	self behavior ifNotNil: [ ^self ].
	bh := (ConditionBehavior new condition: (self debugPoint properties at: #Condition ifAbsent: '')).
	self debugPoint addBehavior: bh.
	self behavior: bh
]

{ #category : 'layout' }
ConditionUI >> deactivate [
	self debugPoint removeBehavior: ConditionBehavior.
	self behavior: nil.
]

{ #category : 'accessing' }
ConditionUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	
	behavior := self debugPoint getBehavior: ConditionBehavior.
	checkBox state: self behavior isNotNil.
	codeInput enabled: checkBox state.
	(self behavior ifNotNil: [:bh | codeInput text: bh condition]).

]

{ #category : 'layout' }
ConditionUI >> defaultLayout [ 
	| newLayout |
	
	newLayout := SpBoxLayout newTopToBottom
		add: checkBox expand: false;
		yourself.
		
	self behavior ifNotNil: [
		newLayout add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: codeInput expand: true ;
			yourself) height: 60;
		yourself].
		
	^newLayout

]

{ #category : 'initialization' }
ConditionUI >> initializePresenters [ 
	
	codeInput  := self newCode.
	codeInput beForScripting.
	codeInput whenTextChangedDo: [ self behavior ifNotNil: [behavior condition: codeInput text ]].
	checkBox := self newCheckBox label: 'Condition'.
	checkBox whenActivatedDo: [ self activate ].
	checkBox whenDeactivatedDo: [ self deactivate ].
	
	
]
