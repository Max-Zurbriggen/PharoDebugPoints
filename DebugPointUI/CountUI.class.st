Class {
	#name : #CountUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'textInput'
	],
	#category : #DebugPointUI
}

{ #category : #accessing }
CountUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.

	textInput text: self debugPoint count asString.
]

{ #category : #layout }
CountUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Counter') expand: false ;
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: (self newLabel label: 'Current Count:') expand: false ;
			add: textInput  expand: true ;
			add: (self newButton label: 'reset'; action: [self debugPoint count: 0. self update]) expand: false ;
			yourself) expand: false;
		yourself.
		

]

{ #category : #initialization }
CountUI >> initializePresenters [ 
	
	textInput := self newTextInput beNotEditable .

]
