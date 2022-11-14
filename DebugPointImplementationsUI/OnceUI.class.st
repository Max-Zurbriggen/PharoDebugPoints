Class {
	#name : #OnceUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'checkBox'
	],
	#category : #DebugPointImplementationsUI
}

{ #category : #layout }
OnceUI >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint.
	checkBox state: (self debugPoint getBehavior: OnceBehavior) isNotNil.
	checkBox whenActivatedDo: [ self debugPoint addBehavior: OnceBehavior new ].
	checkBox whenDeactivatedDo: [ self debugPoint removeBehavior: OnceBehavior ].
]

{ #category : #layout }
OnceUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom
		add: (checkBox label: 'Once') expand: false;
		yourself.
]

{ #category : #layout }
OnceUI >> initializePresenters [ 
	
	checkBox  := self newCheckBox.

]
