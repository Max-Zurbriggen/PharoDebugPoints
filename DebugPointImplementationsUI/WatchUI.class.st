Class {
	#name : #WatchUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'historyList',
		'textInput2'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
WatchUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Watch') expand: false ;
		add: ( SpBoxLayout newTopToBottom  borderWidth: 5;
			add: ( SpBoxLayout newLeftToRight
				add: (self newLabel label: 'History:') expand: true;
				add: (self newLabel label: 'Limit:   ' ) expand: false;
				add: textInput2  expand: false ;
				yourself) height: 25;	
			add: historyList expand: true;
			yourself) expand: true;
		yourself.
		

]

{ #category : #layout }
WatchUI >> initializePresenters [ 
	
	historyList := self newList 
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem inspect ].
	textInput2 := self newNumberInput beInteger; minimum: 0.
	textInput2 whenNumberChangedDo: [ :a | behavior limit: (textInput2 number ) ]
]

{ #category : #layout }
WatchUI >> update [

	textInput2 number: (behavior limit ifNil:[''] ifNotNil: [:s|s]).
	historyList items: behavior history.
]
