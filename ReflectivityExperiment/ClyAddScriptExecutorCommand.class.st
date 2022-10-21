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
	^#class
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
	
	"SimpleBreakpoint installOn: sourceNode"
	"Counter installOn: sourceNode"
	ScriptExecutor installOn: sourceNode
	"ConditionalBreakpoint installOn: sourceNode"
	"OnceBreakpoint installOn: sourceNode"
]

{ #category : #execution }
ClyAddScriptExecutorCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
