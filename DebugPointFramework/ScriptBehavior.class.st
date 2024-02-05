"
I am a script behavior that can be added to debug points. I execute arbitrary code that is saved in my script variable.
"
Class {
	#name : 'ScriptBehavior',
	#superclass : 'DebugPointBehavior',
	#instVars : [
		'script'
	],
	#category : 'DebugPointFramework-Behaviors',
	#package : 'DebugPointFramework',
	#tag : 'Behaviors'
}

{ #category : 'accessing' }
ScriptBehavior class >> uiElement [ 

	^ScriptUI
]

{ #category : 'execution' }
ScriptBehavior >> execute [
	self script ifNil: [ ^true ].
	Smalltalk compiler evaluate: self script.
	^true.
]

{ #category : 'cleanup' }
ScriptBehavior >> remove [ 
	"saving the script in case the script behavior is added again later"
	self debugPoint properties at: #Script put: self script.
]

{ #category : 'accessing' }
ScriptBehavior >> script [
	^script ifNil:['']
]

{ #category : 'accessing' }
ScriptBehavior >> script: aScript [
	script := aScript 
]
