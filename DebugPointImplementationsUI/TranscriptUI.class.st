Class {
	#name : #TranscriptUI,
	#superclass : #BehaviorUI,
	#instVars : [
		'textInput'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
TranscriptUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Transcript') expand: false ;
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: (self newLabel label: 'Text:') expand: false ;
			add: textInput  expand: true fill:true ;
			yourself) ;
		yourself.
		

]

{ #category : #layout }
TranscriptUI >> initializePresenters [ 
	
	textInput := self newTextInput.
	textInput whenTextChangedDo: [ behavior text: textInput text ]
]

{ #category : #layout }
TranscriptUI >> update [

	textInput text: behavior text.
]
