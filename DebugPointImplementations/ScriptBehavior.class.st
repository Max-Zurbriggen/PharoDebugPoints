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
	Smalltalk compiler evaluate: script.
]

{ #category : #accessing }
ScriptBehavior >> script [
	^script
]

{ #category : #accessing }
ScriptBehavior >> script: aString [
	script := aString
]
