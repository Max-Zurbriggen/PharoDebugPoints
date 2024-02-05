Class {
	#name : 'SeasideRequestUI',
	#superclass : 'DebugPointBehaviorUI',
	#instVars : [
		'textInput'
	],
	#category : 'DebugPointSeaside',
	#package : 'DebugPointSeaside'
}

{ #category : 'layout' }
SeasideRequestUI >> activate [
	| bh |
	self behavior ifNotNil: [ ^self ].
	bh := (SeasideRequestBehavior new ).
	self debugPoint addBehavior: bh.
	self behavior: bh
]

{ #category : 'layout' }
SeasideRequestUI >> deactivate [
	self debugPoint removeBehavior: SeasideRequestBehavior.
	self behavior: nil.
]

{ #category : 'accessing' }
SeasideRequestUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	
	behavior := self debugPoint getBehavior: SeasideRequestBehavior .
	checkBox state: self behavior isNotNil.
	textInput enabled: checkBox state.
	(self behavior ifNotNil: [:bh | textInput text: bh ip]).

]

{ #category : 'layout' }
SeasideRequestUI >> defaultLayout [ 
	| newLayout |
	
	newLayout := SpBoxLayout newTopToBottom
		add: checkBox expand: false;
		yourself.
		
	self behavior ifNotNil: [
		newLayout add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			add: (self newLabel label: 'IP: ') expand: false;
			add: textInput expand: true ;
			yourself) expand: false;
		yourself].
		
	^newLayout

]

{ #category : 'initialization' }
SeasideRequestUI >> initializePresenters [ 
	
	textInput  := self newTextInput.
	textInput whenTextChangedDo: [ self behavior ifNotNil: [behavior ip: textInput text ]].
	checkBox := self newCheckBox label: 'Seaside Request IP'.
	checkBox whenActivatedDo: [ self activate ].
	checkBox whenDeactivatedDo: [ self deactivate ].
	
	
]
