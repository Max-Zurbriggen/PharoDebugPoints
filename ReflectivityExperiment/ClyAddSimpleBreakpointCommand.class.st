Class {
	#name : #ClyAddSimpleBreakpointCommand,
	#superclass : #ClyAdvancedDebuggingCommand,
	#category : #ReflectivityExperiment
}

{ #category : #testing }
ClyAddSimpleBreakpointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasExecutionCounter not ]
]

{ #category : #activation }
ClyAddSimpleBreakpointCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddSimpleBreakpointCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyAddSimpleBreakpointCommand >> defaultMenuItemName [
	^' Add     SimpleBreakpoint    to  ', sourceNode displaySourceCode
]

{ #category : #accessing }
ClyAddSimpleBreakpointCommand >> description [
	^ self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddSimpleBreakpointCommand >> execute [
	
	SimpleBreakpoint installOn: sourceNode
	"Counter installOn: sourceNode"
	"ScriptExecutor installOn: sourceNode"
	"ConditionalBreakpoint installOn: sourceNode"
	"OnceBreakpoint installOn: sourceNode"
]

{ #category : #execution }
ClyAddSimpleBreakpointCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
