Class {
	#name : #ScriptBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'script'
	],
	#category : #'DebugPointFramework-Behaviors'
}

{ #category : #accessing }
ScriptBehavior class >> uiElement [ 

	^ScriptUI
]

{ #category : #execution }
ScriptBehavior >> execute [

	self script ifNil: [ ^true ].
	Smalltalk compiler evaluate: self script.
	
	^true.
]

{ #category : #execution }
ScriptBehavior >> remove [ 
	"saving the script in case the script behavior is added again later"
	self debugPoint properties at: #Script put: self script.
]

{ #category : #execution }
ScriptBehavior >> script [
	^script ifNil:['']
]

{ #category : #execution }
ScriptBehavior >> script: aScript [
	script := aScript 
]
