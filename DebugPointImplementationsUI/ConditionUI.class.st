Class {
	#name : #ConditionUI,
	#superclass : #BehaviorUI,
	#instVars : [
		'codeInput'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
ConditionUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom
		add: (self newLabel label: 'Condition') expand: false ;
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: (self newLabel label: 'Condition:') expand: false ;
			add: codeInput expand: true ;
			yourself) height: 60;
		yourself.
]

{ #category : #layout }
ConditionUI >> initializePresenters [ 
	
	codeInput  := self newCode.
	codeInput beForScripting.
	codeInput whenTextChangedDo: [ behavior condition: codeInput text ]
]

{ #category : #layout }
ConditionUI >> update [

	codeInput text: behavior condition .
]
