Class {
	#name : #ScriptBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'script'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
ScriptBehavior >> execute [ 
	self script ifNil: [ ^self ].
	Smalltalk compiler evaluate: self script.
]

{ #category : #accessing }
ScriptBehavior >> script [
	^script ifNil:['']
]

{ #category : #accessing }
ScriptBehavior >> script: aString [
	script := aString
]

{ #category : #accessing }
ScriptBehavior >> uiElement [ 

	^ScriptUI new behavior: self.
]
