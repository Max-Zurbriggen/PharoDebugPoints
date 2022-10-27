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

{ #category : #execution }
ScriptBehavior >> script [
	^script
]

{ #category : #execution }
ScriptBehavior >> script: aString [
	script := aString
]
