Class {
	#name : #ClyAddCounterCommand,
	#superclass : #ClyAdvancedDebuggingCommand,
	#category : #ReflectivityExperiment
}

{ #category : #testing }
ClyAddCounterCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasExecutionCounter not ]
]

{ #category : #activation }
ClyAddCounterCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddCounterCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddCounterCommand >> defaultMenuItemName [
	^' Add     CounterDebugPoint    to  ', sourceNode displaySourceCode 
]

{ #category : #accessing }
ClyAddCounterCommand >> description [
	^ self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddCounterCommand >> execute [
	
	"TranscriptPoint installOn: sourceNode"
	Counter installOn: sourceNode
	"ScriptExecutor installOn: sourceNode"
	"ConditionalBreakpoint installOn: sourceNode"
	"OnceBreakpoint installOn: sourceNode"
]

{ #category : #execution }
ClyAddCounterCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
