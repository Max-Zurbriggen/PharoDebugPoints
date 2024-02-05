"
I am the UI element for the OnceBehavior of DebugPoints and am added to the DebugPointEditor.
"
Class {
	#name : 'OnceUI',
	#superclass : 'DebugPointBehaviorUI',
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'accessing' }
OnceUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	behavior := self debugPoint getBehavior: OnceBehavior.
	checkBox state: (self debugPoint getBehavior: OnceBehavior) isNotNil.

]

{ #category : 'layout' }
OnceUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom
		add: checkBox expand: false;
		yourself.
]

{ #category : 'initialization' }
OnceUI >> initializePresenters [ 
	
	checkBox  := self newCheckBox label: 'Once'.
	checkBox whenActivatedDo: [ self behavior ifNil: [ debugPoint addBehavior: OnceBehavior new ] ].
	checkBox whenDeactivatedDo: [ 
		self debugPoint removeBehavior: OnceBehavior. 
		self behavior: nil. ].
]
