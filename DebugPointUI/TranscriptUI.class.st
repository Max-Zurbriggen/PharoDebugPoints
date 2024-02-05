"
I am the UI element for the TranscriptBehavior of DebugPoints and am added to the DebugPointEditor.
"
Class {
	#name : 'TranscriptUI',
	#superclass : 'DebugPointBehaviorUI',
	#instVars : [
		'textInput'
	],
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'private' }
TranscriptUI >> activate [
	| bh |
	self behavior ifNotNil: [ ^self ].
	bh := (TranscriptBehavior new text: (self debugPoint properties at: #TranscriptText ifAbsent: '')).
	self debugPoint addBehavior: bh.
	self behavior: bh
]

{ #category : 'private' }
TranscriptUI >> deactivate [
	self debugPoint removeBehavior: TranscriptBehavior.
	self behavior: nil.
]

{ #category : 'accessing' }
TranscriptUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	
	behavior := self debugPoint getBehavior: TranscriptBehavior.
	checkBox state: self behavior isNotNil.
	textInput enabled: checkBox state.
	(self behavior ifNotNil: [:bh | textInput text: bh text]).

]

{ #category : 'layout' }
TranscriptUI >> defaultLayout [ 
	| newLayout |
	
	newLayout := SpBoxLayout newTopToBottom
		add: checkBox expand: false;
		yourself.
		
	self behavior ifNotNil: [
		newLayout add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: textInput expand: true ;
			yourself) height: 60;
		yourself].
		
	^newLayout

]

{ #category : 'initialization' }
TranscriptUI >> initializePresenters [ 
	
	textInput  := self newText.
	textInput whenTextChangedDo: [ self behavior ifNotNil: [behavior text: textInput text ]].
	checkBox := self newCheckBox label: 'Transcript'.
	checkBox whenActivatedDo: [ self activate ].
	checkBox whenDeactivatedDo: [ self deactivate ].
	
	
]
