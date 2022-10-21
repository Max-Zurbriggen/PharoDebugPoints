Class {
	#name : #ScriptExecutor,
	#superclass : #DebugPoint,
	#instVars : [
		'script'
	],
	#classVars : [
		'AllScriptExecutors'
	],
	#category : #ReflectivityExperiment
}

{ #category : #accessing }
ScriptExecutor >> hit [
	self runScript.
]

{ #category : #accessing }
ScriptExecutor >> initialize [ 
	super initialize. 
	
	script := self newScriptPopup.
]

{ #category : #accessing }
ScriptExecutor >> newScriptPopup [

	| textInput |
	textInput := SpRequestTextDialog new
		label: 'Enter code for this point:';
		text: '';
		title: 'Enter code';
		openModal.
	textInput ifNil: [ ^'' ].
	^textInput 
]

{ #category : #accessing }
ScriptExecutor >> runScript [
	"run the script attached to this object"
	Behavior evaluate: script.
]

{ #category : #accessing }
ScriptExecutor >> script: aString [
	script := aString
]
