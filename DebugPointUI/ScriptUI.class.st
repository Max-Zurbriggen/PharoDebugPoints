Class {
	#name : #ScriptUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'codeInput'
	],
	#category : #DebugPointUI
}

{ #category : #accessing }
ScriptUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.

	codeInput text: self debugPoint script.
]

{ #category : #layout }
ScriptUI >> defaultLayout [ 
	
	
	^SpBoxLayout newTopToBottom
		add: (self newLabel label: 'Script') expand: false ;
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			"add: (self newLabel label: 'Script:') expand: false ;"
			add: codeInput expand: true ;
			yourself) expand: true;
		yourself.
]

{ #category : #initialization }
ScriptUI >> initializePresenters [ 
	
	codeInput := self newCode.
	codeInput beForScripting.
	codeInput whenTextChangedDo: [ self debugPoint script: codeInput text ]
]
