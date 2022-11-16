Class {
	#name : #ScriptUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'codeInput'
	],
	#category : #DebugPointImplementationsUI
}

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

{ #category : #layout }
ScriptUI >> initializePresenters [ 
	
	codeInput := self newCode.
	codeInput beForScripting.
	codeInput whenTextChangedDo: [ behavior script: codeInput text ]
]

{ #category : #layout }
ScriptUI >> update [

	codeInput text: behavior script.
]
