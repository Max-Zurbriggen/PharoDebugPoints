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
	behavior := self debugPoint getBehavior: OnceBehavior.
	checkBox state: (self debugPoint getBehavior: OnceBehavior) isNotNil.

]

{ #category : #layout }
OnceUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom
		add: checkBox expand: false;
		yourself.
]

{ #category : #layout }
OnceUI >> initializePresenters [ 
	
	checkBox  := self newCheckBox label: 'Once'.
	checkBox whenActivatedDo: [ self behavior ifNil: [ debugPoint addBehavior: OnceBehavior new ] ].
	checkBox whenDeactivatedDo: [ self debugPoint removeBehavior: OnceBehavior ].
]

{ #category : #layout }
OnceUI >> update [ 
	checkBox update.
]
