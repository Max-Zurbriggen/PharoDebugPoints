Class {
	#name : #CountUI,
	#superclass : #BehaviorUI,
	#instVars : [
		'textInput'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
CountUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Counter') expand: false ;
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: (self newLabel label: 'Current Count:') expand: false ;
			add: textInput  expand: true ;
			add: (self newButton label: 'reset'; action: [behavior count: 0. self update]) height: 1 ;
			yourself) ;
		yourself.
		

]

{ #category : #layout }
CountUI >> initializePresenters [ 
	
	textInput := self newTextInput beNotEditable .
	"textInput whenTextChangedDo: [ behavior count: textInput text ]"
]

{ #category : #layout }
CountUI >> update [

	textInput text: behavior count asString.
]
