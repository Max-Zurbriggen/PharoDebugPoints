"
I am a debug point that executes a script when hit.
"
Class {
	#name : #ScriptDebugPoint,
	#superclass : #DebugPoint,
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #initialization }
ScriptDebugPoint >> initialize [ 
	super initialize.
	
	self behaviors add: (ScriptBehavior new debugPoint: self).
	(self getBehavior: ScriptBehavior) script: self popUp.
]

{ #category : #accessing }
ScriptDebugPoint >> name [
	^name ifNil: [ #Script ]

]

{ #category : #accessing }
ScriptDebugPoint >> popUp [
	|textInput|
	textInput := SpRequestDialog new
		label: 'Enter script:';
		text: '';
		title: 'Script';
		openModal.
	textInput ifNil: [ ^'' ].
	^textInput 
]
