Class {
	#name : #ClyAddOnceBreakpointDebugPointCommand,
	#superclass : #ClyAdvancedDebuggingCommand,
	#category : #ReflectivityExperiment
}

{ #category : #testing }
ClyAddOnceBreakpointDebugPointCommand class >> canBeExecutedInContext: aBrowserContext [

	^ (super canBeExecutedInContext: aBrowserContext) and: [ 
		  aBrowserContext isSelectedItemHasExecutionCounter not ]
]

{ #category : #activation }
ClyAddOnceBreakpointDebugPointCommand class >> contextMenuOrder [
	^2
]

{ #category : #accessing }
ClyAddOnceBreakpointDebugPointCommand >> defaultMenuIconName [
	^#class
]

{ #category : #accessing }
ClyAddOnceBreakpointDebugPointCommand >> defaultMenuItemName [
	^' Add     OnceBreakpoint    to  ', sourceNode displaySourceCode
]

{ #category : #accessing }
ClyAddOnceBreakpointDebugPointCommand >> description [
	^ self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]

{ #category : #execution }
ClyAddOnceBreakpointDebugPointCommand >> execute [
	
	"SimpleBreakpoint installOn: sourceNode"
	"Counter installOn: sourceNode"
	"ScriptExecutor installOn: sourceNode"
	"ConditionalBreakpoint installOn: sourceNode"
	OnceBreakpoint installOn: sourceNode
]

{ #category : #execution }
ClyAddOnceBreakpointDebugPointCommand >> information [
	self defaultMenuItemName, ' to  ',  sourceNode displaySourceCode
]
