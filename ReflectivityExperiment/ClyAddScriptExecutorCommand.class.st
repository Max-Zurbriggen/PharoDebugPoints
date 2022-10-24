Class {
	#name : #ClyAddScriptExecutorCommand,
	#superclass : #ClyAdvancedDebuggingCommand,
	#category : #ReflectivityExperiment
}

{ #category : #testing }
ClyAddScriptExecutorCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasExecutionCounter not ]
]

{ #category : #activation }
ClyAddScriptExecutorCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddScriptExecutorCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddScriptExecutorCommand >> defaultMenuItemName [
	^' Add     ScriptExecutor    to  ', sourceNode displaySourceCode
]

{ #category : #accessing }
ClyAddScriptExecutorCommand >> description [
	^ self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddScriptExecutorCommand >> execute [
	
	| textInput |
	textInput := SpRequestTextDialog new
		label: 'Enter script to execute when hitting this point:';
		text: '';
		title: 'Enter code';
		openModal.
	textInput ifNil: [ ^'' ].
	(ScriptExecutor installOn: sourceNode) script: textInput .

]

{ #category : #execution }
ClyAddScriptExecutorCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
