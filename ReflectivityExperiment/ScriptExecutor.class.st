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
	self script: ''
]

{ #category : #accessing }
ScriptExecutor >> newScriptPopup [

	| textInput |
	textInput := SpRequestTextDialog new
		label: 'Enter script to execute when hitting this point:';
		text: '';
		title: 'Enter code';
		openModal.
	textInput ifNil: [ ^self script ].
	^textInput 
]

{ #category : #accessing }
ScriptExecutor >> runScript [
	"run the script attached to this object"
	Behavior evaluate: script.
]

{ #category : #accessing }
ScriptExecutor >> script [ 
	^script
]

{ #category : #accessing }
ScriptExecutor >> script: aString [
	script := aString
]
