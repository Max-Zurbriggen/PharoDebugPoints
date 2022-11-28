Class {
	#name : #TranscriptUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'textInput'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #accessing }
TranscriptUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.

	textInput text: self debugPoint text.
]

{ #category : #layout }
TranscriptUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Transcript') expand: false ;
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			"add: (self newLabel label: 'Text:') expand: false ;"
			add: textInput  expand: true fill:true ;
			yourself) ;
		yourself.
		

]

{ #category : #initialization }
TranscriptUI >> initializePresenters [ 
	
	textInput := self newTextInput.
	textInput whenTextChangedDo: [ self debugPoint text: textInput text ]
]
