"
I am the UI element for the ScriptBehavior of DebugPoints and am added to the DebugPointEditor.
"
Class {
	#name : 'ScriptUI',
	#superclass : 'DebugPointBehaviorUI',
	#instVars : [
		'codeInput'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'private' }
ScriptUI >> activate [
	| bh |
	self behavior ifNotNil: [ ^self ].
	bh := (ScriptBehavior new script: (self debugPoint properties at: #Script ifAbsent: '')).
	self debugPoint addBehavior: bh.
	self behavior: bh
]

{ #category : 'private' }
ScriptUI >> deactivate [
	self debugPoint removeBehavior: ScriptBehavior.
	self behavior: nil.
]

{ #category : 'accessing' }
ScriptUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	behavior := self debugPoint getBehavior: ScriptBehavior.
	checkBox state: self behavior isNotNil.
	
	(self behavior ifNotNil: [:bh | codeInput text: bh script]).
]

{ #category : 'layout' }
ScriptUI >> defaultLayout [ 
	| newLayout |
	newLayout := SpBoxLayout newTopToBottom 
		add: checkBox expand: false;
		yourself.
		
	self behavior ifNotNil: [
		newLayout add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: codeInput expand: true ;
			yourself) expand: true;
		yourself].
		
	^newLayout
	
]

{ #category : 'layout' }
ScriptUI >> expand [
	^true
]

{ #category : 'initialization' }
ScriptUI >> initializePresenters [ 
	
	checkBox  := self newCheckBox label: 'Script'.
	checkBox whenActivatedDo: [ self activate ].
	checkBox whenDeactivatedDo: [ self deactivate ].
	
	codeInput := self newCode.
	codeInput beForScripting.
	codeInput whenTextChangedDo: [ self behavior ifNotNil: [behavior script: codeInput text ]].
]
