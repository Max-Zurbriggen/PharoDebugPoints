"
I am the UI element for the TestEnvironmentBehavior of DebugPoints and am added to the DebugPointEditor.
"
Class {
	#name : 'TestEnvironmentUI',
	#superclass : 'DebugPointBehaviorUI',
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'accessing' }
TestEnvironmentUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	behavior := self debugPoint getBehavior: TestEnvironmentBehavior .
	checkBox state: (self debugPoint getBehavior: TestEnvironmentBehavior) isNotNil.

]

{ #category : 'layout' }
TestEnvironmentUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom
		add: checkBox expand: false;
		yourself.
]

{ #category : 'initialization' }
TestEnvironmentUI >> initializePresenters [ 
	
	checkBox  := self newCheckBox label: 'Test Environment Only'.
	checkBox whenActivatedDo: [ self behavior ifNil: [ debugPoint addBehavior: TestEnvironmentBehavior new ] ].
	checkBox whenDeactivatedDo: [ 
		self debugPoint removeBehavior: TestEnvironmentBehavior. 
		self behavior: nil. ].
]
