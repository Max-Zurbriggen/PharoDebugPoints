"
I am the UI element for the CountBehavior of DebugPoints and am added to the DebugPointEditor.
"
Class {
	#name : 'CountUI',
	#superclass : 'DebugPointBehaviorUI',
	#instVars : [
		'textInput'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'accessing' }
CountUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	behavior := self debugPoint getBehavior: CountBehavior.
	checkBox state: (self debugPoint getBehavior: CountBehavior) isNotNil.
	behavior ifNotNil: [ 
		textInput text: behavior count asString ].
]

{ #category : 'layout' }
CountUI >> defaultLayout [ 
	| newLayout |
	newLayout := SpBoxLayout newTopToBottom 
		add: checkBox expand: false;
		yourself.
		
	self behavior ifNotNil: [
		newLayout add: self expandedLayout expand: false;
		yourself].
		
	^newLayout

]

{ #category : 'layout' }
CountUI >> expandedLayout [
	^( SpBoxLayout newLeftToRight borderWidth: 5;
			add: (self newLabel label: 'Current Count:') expand: false ;
			add: textInput  expand: true ;
			yourself)
]

{ #category : 'initialization' }
CountUI >> initializePresenters [ 
	
	textInput := self newTextInput beNotEditable .
	
	checkBox  := self newCheckBox label: 'Counter'.
	checkBox whenActivatedDo: [ 
		self behavior ifNil: [ 
			debugPoint addBehavior: CountBehavior new ] ].
	checkBox whenDeactivatedDo: [ 
		
		self debugPoint removeBehavior: CountBehavior. 
		self behavior: nil. ].
]
