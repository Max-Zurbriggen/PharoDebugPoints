"
I am a debug point that executes a script when hit.
"
Class {
	#name : #ScriptDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'script'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
ScriptDebugPoint >> hitWithContext: aContext [
	<debuggerCompleteToSender>
	
	(super hitWithContext: aContext) ifFalse: [^self].

	self script ifNil: [ ^self ].
	Smalltalk compiler evaluate: self script.
]

{ #category : #accessing }
ScriptDebugPoint >> name [
	^#Script
]

{ #category : #accessing }
ScriptDebugPoint >> script [
	^script ifNil:['']
]

{ #category : #accessing }
ScriptDebugPoint >> script: aString [
	script := aString.

]

{ #category : #'ui building' }
ScriptDebugPoint >> uiElement [ 

	^ScriptUI new debugPoint: self.
]
